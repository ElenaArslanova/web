<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>Graphs</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Catamaran">
	<link rel="stylesheet" type="text/css" href="../css/algorithms.css">
	<link rel="shortcut icon" href="../images/favicon.ico">
	<meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>
	%include('header.tpl')
	<!-- Search algorithms -->
	<div id="search-algorithms">
		<div class="container-fluid">
			<div class="row group-header">
				<div class="col-sm-12 text-center lead margin-section">Поиск в графе</div>
			</div>
			<div class="row">
				<div class="col-sm-4">
					<div class="card text-center">
						<img src="../images/traverse.png" class="card-img-top" alt="">
						<div class="card-block">
							<h4 class="card-title">Обход графа</h4>
							<ul class="list-group">
								<li><a href="#" class="list-group-item list-group-item-action">Поиск в ширину</a></li>
								<li><a href="#" class="list-group-item list-group-item-action">Поиск в глубину</a></li>
							</ul>
						</div>
					</div>
				</div>
				<div class="col-sm-4">
					<div class="card text-center">
						<img src="../images/tree.jpg" class="card-img-top" alt="">
						<div class="card-block">
							<h4 class="card-title">Минимальный остов</h4>
							<ul class="list-group">
								<li><a href="#" class="list-group-item list-group-item-action">Алгоритм Борувки</a></li>
								<li><a href="#" class="list-group-item list-group-item-action">Алгоритм Прима</a></li>
							</ul>
						</div>
					</div>
				</div>
				<div class="col-sm-4">
					<div class="card text-center">
						<img src="../images/path.jpg" class="card-img-top" alt="">
						<div class="card-block">
							<h4 class="card-title">Кратчайший путь</h4>
							<ul class="list-group">
								<li><a href="#" class="list-group-item list-group-item-action">Алгоритм Форда-Беллмана</a></li>
								<li><a href="#" class="list-group-item list-group-item-action">Алгоритм Дейкстры</a></li>
							</ul>
						</div>
					</div>
				</div>				
			</div>			
		</div>
		<!-- /Search algorithms -->
		<!-- Flow algorithms -->
		<div id="flow-algorithms">
			<div class="container-fluid">
				<div class="row group-header">
					<div class="col-sm-12 text-center lead">Потоки в сетях</div>
				</div>
				<div class="row">
					<div class="col-sm-4">
						<div class="card text-center">
							<img src="../images/maxflow.png" class="card-img-top" alt="">
							<div class="card-block">
								<h4 class="card-title">Максимальный поток</h4>
								<ul class="list-group">
									<li><a href="#" class="list-group-item list-group-item-action">Алгоритм Флойда-Фалкерсона</a></li>
									<li><a href="#" class="list-group-item list-group-item-action">Поиск f-дополняющей цепи</a></li>
								</ul>
							</div>
						</div>
					</div>
					<div class="col-sm-4">
						<div class="card text-center">
							<img src="../images/pipes.png" class="card-img-top" alt="">
							<div class="card-block">
								<h4 class="card-title">Ограничение потока</h4>
								<ul class="list-group">
									<li><a href="#" class="list-group-item list-group-item-action">С ограничением на пропускную способность</a></li>
									<li><a href="#" class="list-group-item list-group-item-action">Поиск f-допустимого потока</a></li>
								</ul>
							</div>
						</div>
					</div>
					<div class="col-sm-4">
						<div class="card text-center">
							<img src="../images/tap.png" class="card-img-top" alt="">
							<div class="card-block">
								<h4 class="card-title">Поток заданной величины</h4>
								<ul class="list-group">
									<li><a href="#" class="list-group-item list-group-item-action">Поиск потока </a></li>
									<li><a href="#" class="list-group-item list-group-item-action">Поиск минимального потока</a></li>
								</ul>
							</div>
						</div>
					</div>					
				</div>
			</div>
		</div>
		<!-- /Flow algorithms -->
		<!-- Matching algorithms -->
		<div id="matching-algorithms">
			<div class="container-fluid">
				<div class="row group-header">
					<div class="col-sm-12 text-center lead">Паросочетания</div>
				</div>
				<div class="row">
					<div class="col-sm-4">
						<div class="card text-center">
							<img src="../images/matching1.png" class="card-img-top" alt="">
							<div class="card-block">
								<h4 class="card-title">Наибольшее паросочетание</h4>
								<ul class="list-group">
									<li><a href="#" class="list-group-item list-group-item-action">Алгоритм Форда-Фалкерсона (модификация)</a></li>
									<li><a href="#" class="list-group-item list-group-item-action">Алгоритм Хопкрофта-Карпа</a></li>
								</ul>
							</div>
						</div>
					</div>
					<div class="col-sm-4">
						<div class="card text-center">
							<img src="../images/tools.png" class="card-img-top" alt="">
							<div class="card-block">
								<h4 class="card-title">Дополнительные структуры</h4>
								<ul class="list-group">
									<li><a href="#" class="list-group-item list-group-item-action">Поиск М-чередующейся цепи</a></li>
									<li><a href="#" class="list-group-item list-group-item-action">Построение M-множества</a></li>
								</ul>
							</div>
						</div>
					</div>
					<div class="col-sm-4">
						<div class="card text-center">
							<img src="../images/box.png" class="card-img-top" alt="">
							<div class="card-block">
								<h4 class="card-title">Полное паросочетание</h4>
								<ul class="list-group">
									<li><a href="#" class="list-group-item list-group-item-action">Алгоритм Куна</a></li>
									<li><a href="#" class="list-group-item list-group-item-action">Венгерский алгоритм</a></li>
								</ul>
							</div>
						</div>
					</div>					
				</div>
			</div>
		</div>
		<!-- /Matching algorithms -->
	</div>
</body>
</html>