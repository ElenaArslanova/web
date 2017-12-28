from sqlalchemy import create_engine, or_, and_, desc
from sqlalchemy.orm import sessionmaker
import datetime

from db.base import Base, Photo, User, Comment, Edition, Visit


class Alchemy:
    def __init__(self, path=''):
        engine = create_engine('sqlite:///{}'.format(path))
        Base.metadata.bind = engine
        DBSession = sessionmaker(bind=engine)
        self.__session = DBSession()
        self.__counter_file = 'db//counter.txt'

    def get_session(self):
        return self.__session

    def get_photos(self):
        return self.__session.query(Photo).all()

    def is_free_log_email(self, potential_login, potential_email):
        user_filter = self.__session.query(User).filter(or_(User.login == potential_login,
                                                            User.email == potential_email)).all()
        if user_filter:
            return False
        return True

    def add_comment(self, photo_id, comment_text, user):
        user_id = self.__session.query(User).filter(User.login == user).one().id
        comment = Comment(photo_id, user_id, comment_text, datetime.datetime.now())
        self.__session.add(comment)
        self.__session.commit()

    def get_comments(self, photo_obj):
        comments = photo_obj.comments
        return [[c.id, c.text, c.date, self.__session.query(User).filter(User.id == c.user_id).all()[0].login]
                for c in comments]

    def add_edition(self, comment_id, user, text):
        user_id = self.__session.query(User).filter(User.login == user).one().id
        comment = self.__session.query(Comment).filter(Comment.id == comment_id).one()
        edition = Edition(comment.photo_id, user_id, comment_id, text, comment.date)
        comment.text = text
        self.__session.add(edition)
        self.__session.commit()

    def get_editions(self, comment_id, user):
        user_id = self.__session.query(User).filter(User.login == user).one().id
        editions = self.__session.query(Edition).filter(
            and_(Edition.comment_id == comment_id, Edition.user_id == user_id)).order_by(desc(Edition.date)).all()
        return [(e.id, e.date, e.text) for e in editions]

    def update_visit(self, login='anonym', activity='Посещение главной страницы'):
        unique = 1
        if login != 'anonym':
            last_activity = self.__session.query(Visit).filter(Visit.user_logged_in == login).\
                order_by(desc(Visit.date)).all()
            if last_activity:
                last_activity = last_activity[0]
                if datetime.datetime.now() - last_activity.date < datetime.timedelta(minutes=30):
                    unique = 0
        visit = Visit(login, activity, datetime.datetime.now(), unique)
        self.__session.add(visit)
        self.__session.commit()

    def get_user_comments_with_editions(self, user):
        user_id = self.__session.query(User).filter(User.login == user).one().id
        comments = self.__session.query(Comment).filter(Comment.user_id == user_id).all()
        return {(c.text, c.date):self.get_editions(c.id, user) for c in comments}

    def get_visits_count(self, date=False):
        if not date:
            return self.__session.query(Visit).filter(Visit.unique > 0).count()
        return len([v for v in self.__session.query(Visit) if datetime.datetime.now().day == v.date.day and v.unique > 0])

    def get_user_visits(self, login):
        return self.__session.query(Visit).filter(and_(Visit.user_logged_in == login, Visit.unique > 0)).all()

    def get_stat(self, login):
        return self.__session.query(Visit).filter(Visit.user_logged_in == login).all()

    def get_counter(self):
        with open(self.__counter_file) as f:
            return int(f.read())

    def update_counter(self, value):
        with open(self.__counter_file, 'w') as f:
            f.seek(0)
            f.truncate()
            f.write(str(value))
