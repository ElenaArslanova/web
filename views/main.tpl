<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>Graphs</title>
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
		<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Catamaran">
		<link rel="stylesheet" type="text/css" href="../css/main.css">
		<link rel="shortcut icon" href="../images/favicon.ico">
		<meta name="viewport" content="width=device-width, initial-scale=1">
	</head>
	<body>
		%include('header.tpl')
		<!-- Home -->
		<div id="home" class="home">
			<div class="home-text text-vcenter">
				<h1>Graphs</h1>
				<h3>Погружение в алгоритмы</h3>
				<a href="algorithms" class="btn btn-default btn-lg">Начать</a>
			</div>
			<div id="modal-form" class="modal">
				<span onclick="document.getElementById('modal-form').style.display='none'" class="close">&times;</span>
				<form id="login-form" class="modal-content" name ='log' action="/login" method="post" enctype="multipart/form-data">
					<div class="form-group form-content text-center">
						<p><h2>Вход</h2></p>
						<input class="form-control" type="text" name="user" placeholder="Логин" required>
					    <input class="form-control" type="password" name="password" placeholder="Пароль" required>
					    <input value='Войти' type="submit">
					</div>
				</form>
				<form id="registration-form" class="modal-content" name='registration' action="/login" method="post" enctype="multipart/form-data">
					<div class="form-group form-content text-center">
						<p><h2>Регистрация</h2></p>
			    		<input class="form-control" type="text" name="user_start" placeholder="Логин" required>
			    		<input class="form-control" type="email" name="email_start" placeholder="Email" required>
					    <input class="form-control" type="password" name="password_start" placeholder="Пароль" required>
					    <input value='Зарегистрироваться' type="submit">	
					</div>
				</form>
				<div class="container-fluid">
					<div class="row">
					    <div class="col-xs-6 option" id="reg-option"><p class="option-text">Регистрация</p></div>
					    <div class="col-xs-6 option" id="log-option"><p class="option-text">Вход</p></div>
					</div>
				</div>
			</div>
		</div>
		<!-- /Home -->
		<!-- Visits Info -->
		<div id="visits-info" class="pad-section">
			<div class="container">
				<div class="row">
					<div class="col-xs-offset-1 col-sm-5">
						<div class="card">
							<div class="card-body">
								<h4 class="card-title">Статистика</h4>
								<ul class="list-group stats" style="display: inline-block;">
									<li class="list-group-item">
										<span class="info-text">Последнее посещение: {{last_time_visit}}</span>
									</li>
									<li class="list-group-item">
										<div style="position: relative;">
											<span class="info-text">Всего посещений:</span>
											<div class="text-center">
												<ul>{{!total_visits}}</ul>
											</div>
										</div>
									</li> 
									<li class="list-group-item">
										<div style="position: relative;">
											<span class="info-text">Посещений сегодня:</span>
											<div class="text-center">
												<ul>{{!today_visits}}</ul>
											</div>
										</div> 
									</li>
									<li class="list-group-item">
										<div style="position: relative;">
											<span class="info-text">Heat'ов:</span>
											<div class="text-center">
												<ul>{{!heat}}</ul>
											</div>
										</div>
									</li>
								</ul>
							</div>
						</div>
					</div>
					<div class="col-sm-5">
						<div class="card">
							<div class="card-body">
								<h4 class="card-title">Информация о браузере</h4>
								<ul class="list-group">
									<li class="list-group-item info-text">Браузер: {{browser}}</li>
									<li class="list-group-item info-text">Версия: {{version}}</li>
									<li class="list-group-item info-text" id="screen">Разрешение экрана: {{screen}}</li>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- /Visits Info -->
		<!-- About -->
		<div id="about" class="pad-section">
			<div class="container">
				<div class="row">
					<div class="col-sm-6">
						<img src="../images/logo.png" alt="">
					</div>
					<div class="col-sm-6 text-center margin-section">
						<p class="lead">Графовые алгоритмы с пошаговым объяснением и примерами кода на Python</p>
					</div>
				</div>
			</div>
		</div>
		<!-- /About -->
		<!-- Sections -->
		<div id="sections" class="pad-section">
			<div class="container">
				<h2 class="text-center">Разделы</h2>
				<div class="row text-center">
					<div class="col-sm-3 col-xs-6">
						<i class="fa fa-check-circle-o" aria-hidden="true"></i>
						<p>Типы графов</p>
					</div>
					<div class="col-sm-3 col-xs-6">
						<i class="fa fa-list-ol" aria-hidden="true"></i>
						<p>Пошаговое объяснение</p>
					</div>
					<div class="col-sm-3 col-xs-6">
						<i class="fa fa-product-hunt" aria-hidden="true"></i>
						<p>Примеры кода на Python</p>
					</div>
					<div class="col-sm-3 col-xs-6">
						<i class="fa fa-picture-o" aria-hidden="true"></i>
						<p>Поясняющие изображения</p>
					</div>
				</div>
			</div>
		</div>
		<!-- /Sections -->
		<!-- BFS Example -->
		<div id="bfs-example" class="pad-section">
			<div class="container">
				<div class="row">
					<div class="col-sm-6">
						<div class="panel panel-default">
							<div class="panel-heading">Поиск пути</div>
							<div class="panel-body lead">Составляй эффективные по времени маршруты, используя <a href="#">BFS</a></div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- /BFS Example -->
		<!-- Stat -->
		<div id="stat" class="pad-section">
			<div class="container">
				<div class="row text-center">
					<div class="col-sm-4">
						<h3>30 алгоритмов</h3>
					</div>
					<div class="col-sm-4">
						<h3>5 видов графов</h3>
					</div>
					<div class="col-sm-4">
						<h3>100 изображений</h3>
					</div>
				</div>
			</div>
		</div>
		<!-- /Stat -->
		<!-- Hamiltonian path Example -->
		<div id="hamiltonian-example" class="pad-section">
			<div class="container">
				<div class="row">
					<div class="col-sm-6 col-large pull-right">
						<div class="panel panel-default">
							<div class="panel-body lead">Посети все места во время путешествия - узнай, как строить <a href="#">Гамильтонов путь</a></div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- /Hamiltonian path Example -->
		<!-- Footer -->
		%include('footer.tpl', name='Elena Arslanova', year='2017')
		<!-- /Footer -->
		<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
		<script type="text/javascript" src="../scripts/cookie.js"></script>
		<script type="text/javascript" src="../scripts/main.js"></script>
		<script type="text/javascript" src="../scripts/ajax.js"></script>
		<script type="text/javascript" src="../scripts/xml.js"></script>
	</body>
</html>