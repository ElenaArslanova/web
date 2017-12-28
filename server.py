import bottle
import datetime
import httpagentparser
from beaker.middleware import SessionMiddleware
from bottle import route, request, error, response, template, post, get, run, static_file
from cork import Cork, AuthException

from sk import email, pswd, enc_key
from db.alchemy import Alchemy
from db.base import User, Photo, Comment
from escape import Escaper
from counter import convert_counter_in_html

cork = Cork('info', email_sender=email,
           smtp_url='starttls://{}:{}@smtp.gmail.com:587'.format(email, pswd))

alchemy = Alchemy(path='db/data.db')

escaper = Escaper()

application = bottle.app()

counter = alchemy.get_counter()

session_opts = {
    'session.cookie_expires': True,
    'session.httponly': True,
    'session.timeout': 3600 * 24,
    'session.type': 'cookie',
    'session.validate_key': True,
}
application = SessionMiddleware(application, session_opts)


def get_main_page_info():
    browser_info = httpagentparser.detect(request.environ.get('HTTP_USER_AGENT'))['browser']
    info = {}
    info['last_time_visit'] = datetime.datetime.now().strftime('%H:%M %d-%m-%Y')
    info['browser'] = browser_info.get('name')
    info['version'] = browser_info.get('version')
    info['screen'] = ''
    info['heat'] = convert_counter_in_html(str(counter))
    info['total_visits'] = convert_counter_in_html(str(alchemy.get_visits_count()))
    info['today_visits'] = convert_counter_in_html(str(alchemy.get_visits_count(True)))
    return info


@route('/')
def login():
    global counter
    counter += 1
    logged_in = is_logged_in()
    if logged_in:
        login = cork.current_user.username
    else:
        login = 'anonym'
    alchemy.update_visit(login, 'Посещение главной страницы')
    return template('views/main.tpl', logged_in=logged_in,
                    **get_main_page_info())


@route('/validate_registration/<registration_code>')
def validate_registration(registration_code):
    cork.validate_registration(registration_code)
    return '<a href="/#login">Вернуться ко входу</a>'

@route('/login', method='POST')
def do_auth():
    log_us = request.forms.get('user', '')
    log_pass = request.forms.get('password', '')

    if log_us and log_pass:
        cork.login(log_us, log_pass, success_redirect='/', fail_redirect='/#login')

    username = request.forms.get('user_start')
    password = request.forms.get('password_start')
    email = request.forms.get('email_start')

    if username and password and email:
        if alchemy.is_free_log_email(username, email):
            cork.register(username, password, email, email_template='views/registration_temp.tpl')
            user = User(login=username, password=password, email=email)
            session = alchemy.get_session()
            session.add(user)
            session.commit()
            return 'Проверьте вашу почту'
    global counter
    counter += 1
    return template('views/main.tpl', logged_in=is_logged_in(), **get_main_page_info())


@route('/gallery')
def gallery():
    photos = alchemy.get_photos()
    groups = [photos[i:i + 4] for i in range(0, len(photos), 4)]
    if is_logged_in():
        username = cork.current_user.username
    else:
        username = ''
    comments = [alchemy.get_comments(p) for p in photos]
    return escaper.escape(template('views/gallery.tpl', groups=groups, comments=comments,
                    logged_in=is_logged_in(), username=username))

@route('/comment/<img>', method='post')
def add_comment(img):
    cork.require(fail_redirect='/#login')
    photo_id = int(img.replace('img', ''))
    comment = request.forms.get('comment')
    username = cork.current_user.username
    alchemy.add_comment(photo_id, comment, username)
    alchemy.update_visit(username, 'Новый комментарий к картинке номер {}'.format(photo_id))
    return bottle.redirect('/gallery')

@route('/edit/<comment>', method='post')
def edit(comment):
    cork.require(fail_redirect='/#login')
    comment_id = int(comment.replace('comment', ''))
    text = request.forms.get('comment')
    user = cork.current_user.username
    alchemy.add_edition(comment_id, user, text)
    alchemy.update_visit(user, 'Редактирование комментария')
    return bottle.redirect('/gallery')

@route('/logout')
def logout():
    cork.require(fail_redirect='/#login')
    alchemy.update_visit(cork.current_user.username, 'Выход из профиля')
    cork.logout(success_redirect='/')

@route('/algorithms')
def algorithms():
    logged_in = is_logged_in()
    if logged_in:
        login = cork.current_user.username
    else:
        login = 'anonym'
    alchemy.update_visit(login, 'Просмотр алгоритмов')
    return template('views/algorithms.tpl', logged_in=is_logged_in())

@route('/stats')
def stats():
    cork.require(fail_redirect='/#login')
    alchemy.update_visit(cork.current_user.username, 'Просмотр статистики')
    stats = alchemy.get_stat(cork.current_user.username)
    visits = alchemy.get_user_visits(cork.current_user.username)
    return template('views/statistics.tpl', name=cork.current_user.username, stat=stats, visits=visits,
                    logged_in=is_logged_in(),
                    comment_editions=alchemy.get_user_comments_with_editions(cork.current_user.username))

@route('/<filename:path>')
def send_file(filename):
    return static_file(filename, root='static/')

def is_logged_in():
    try:
        user = cork.current_user
        return bool(user)
    except Exception:
        return False


if __name__ == "__main__":
    bottle.debug(True)
    bottle.run(app=application, host='localhost', port=8080)
    alchemy.update_counter(counter)

    # thmb_paths = ["../images/thmb_polygons.jpg", "../images/thmb_home.jpg", "../images/thmb_fence.jpg",
    #               "../images/thmb_pastel1.png",
    #               "../images/thmb_triangles.png", "../images/thmb_pastel2.png", "../images/thmb_valley.jpg",
    #               "../images/thmb_structure.jpg",
    #               "../images/thmb_abstract2.jpg", "../images/thmb_abstract3.jpg", "../images/thmb_lights.jpg",
    #               "../images/thmb_rocks.jpg"]
    # for i in range(1, 13):
    #     photo = Photo(i, thmb_paths[i - 1].replace('thmb_', ''), thmb_paths[i - 1])
    #     session.add(photo)
    #     session.commit()
    # session.commit()
