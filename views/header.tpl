<nav class="navbar navbar-default navbar-fixed-top">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbar-collapse-main">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-title project-title" href="main.html">Graphs</a>
        </div>
        <div class="collapse navbar-collapse" id="navbar-collapse-main">
            <ul class="nav navbar-nav navbar-right">
                <li><a href="/#home">Главная</a></li>
                <li>{{!'<a href="stats">Статистика</a>' if logged_in else '<a href="/#login" id="nav-login">Вход</a>'}}</li>
                <li><a href="/#visits-info">Информация</a></li>
                <li><a href="algorithms">Алгоритмы</a></li>
                <li><a href="gallery">Галерея</a></li>
                <li>{{!'<a href="logout">Выход</a>' if logged_in else ''}}</li>
            </ul>
        </div>
    </div>
</nav>