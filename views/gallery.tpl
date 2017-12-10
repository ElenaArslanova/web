<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>Graphs</title>
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
		<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Catamaran">
		<link rel="stylesheet" type="text/css" href="../css/gallery.css">
		<link rel="shortcut icon" href="../images/favicon.ico">
		<meta name="viewport" content="width=device-width, initial-scale=1">
	</head>
	<body onkeydown="processKeyDown(event);" onload="init(); checkLoading();">
		%include('header.tpl')
		<div id="gallery">
			<div class="container-fluid">
				%for group in groups:
					<div class="row padding-block">
					%for photo in group:
						<div class="col-md-3 col-sm-12">
							<img src="../images/loading.gif" data-src={{photo.thmb_image_path}} id="img{{photo.id}}" class="gallery-img img-thumbnail center-block loading" alt="" onclick="showImage(event);">
						</div>
						<div id="modal-window-{{photo.id}}" class="modal">
							<div class="container-fluid">
								<div class="row">
									<span class="close" onclick="closeImage();">&times;</span>
									<button type="button" id="modal_button" class="btn center-block text-center" style="background-color: #333; color:white; width: 55%;" onclick="setMainPageBackground();">Поставить на фон <br class="visible-xs">главной страницы</button>
									<div class="col-sm-6 col-sm-offset-1">
										<img id="modal-img-{{photo.id}}" class="modal-content img-responsive zoom-content" src="../images/loading.gif" alt="">
									</div>
									<div class="col-sm-4 detail-box">
										<div class="box-title">
											<label>Комментарии</label>
										</div>
										<div class="comment-box">
											<ul class="comment-list">
												%for comment in comments[photo.id-1]:
												<li>
													<div class="container-fluid">
														<div class="row">
															<div class="col-xs-6 username">
																<p>{{comment[3]}}</p>
															</div>
															<div id="edit-{{photo.id}}-{{comment[0]}}" class="col-xs-6 text-right">
																{{!'<i class="fa fa-pencil" onclick="edit_comment(event)"></i>' if username == comment[3] else ""}}
															</div>
														</div>
													</div>
													<div id="comment-{{comment[0]}}" class="comment-text">
														<p id="content-{{comment[0]}}">{{comment[1]}}</p>
														<p class="date sub-text text-right">{{comment[2].strftime('%H:%M %d-%m-%Y')}}</p>
													</div>
												</li>
												%end
											</ul>
											<form class="form-inline" role="form" action="/comment/img{{photo.id}}" method="post" enctype="multipart/form-data">
												<div class="form-group">
													<textarea id="textarea-{{photo.id}}" class="form-control" type="text" placeholder="Ваш комментарий" name="comment" cols="46"></textarea> 
													<button id="addbutton-{{photo.id}}" class="btn btn-default">Добавить</button>
													<button id="editbutton-{{photo.id}}" class="btn btn-default" style="display: none;">Сохранить</button>
												</div>
											</form>
										</div>
									</div>
								</div>
							</div>
						</div>
					%end
					</div>
				%end
			</div>
			<div id="help-window" class="modal">
				<div class="container-fluid">
					<span class="close" onclick="closeHelp();">&times;</span>
					<div class="card card-inverse">
						<div class="card-block text-center">
							<p class="card-title lead">Справка</p>
							<p class="card-text">ESC - выход<br>F1 - справка<br>-&gt; - следующее изображение<br>&lt;- - предыдущее изображение</p>
						</div>
					</div>
				</div>
			</div>
		</div>
		<script type="text/javascript" src="../scripts/cookie.js"></script>
		<script type="text/javascript" src="../scripts/gallery.js"></script>
		<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	</body>
</html>
