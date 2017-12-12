<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>Graphs</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Catamaran">
	<link rel="stylesheet" type="text/css" href="../css/statistics.css">
	<link rel="shortcut icon" href="../images/favicon.ico">
	<meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>
	%include('header.tpl')
	<div class="text-center padding-block"><h4>Персональная статистика</h4></div>
	<div class="container-fluid">
		<div class="table-responsive">
			<table class="table">
				<thead>
					<tr>
						<th>N</th>
						<th>Действие</th>
						<th>Дата</th>
					</tr>
				</thead>
				<tbody>
					%for idx, info in enumerate(stat, start=1):
						<tr>
							<td>{{idx}}</td>
							<td>{{info.activity}}</td>
							<td>{{info.date.strftime('%H:%M %d-%m-%Y')}}</td>
						</tr>
					%end
				</tbody>
			</table>
		</div>
	</div>
	<div class="container-fluid">
		<div class="row">
			<div class="col-xs-12">
				<p class="text-center">Уникальные визиты</p>
				<ul class="list-group">
					%for idx, visit in enumerate(visits, start=1):
						<li class="list-group-item text-center">{{idx}}. {{visit.date.strftime('%H:%M %d-%m-%Y')}}</li>
					%end
				</ul>
			</div>
		</div>
	</div>
	<div class="container-fluid">
		<div class="row">
			<div class="col-xs-12">
				<p class="text-center">История правок сообщений</p>
			</div>
		</div>
		<div class="container-fluid">
			<div class="table-responsive">
				<table class="table">
					<thead>
						<tr class="bold-row">
							<th>Комментарий</th>
							<th>Правки</th>
						</tr>
					</thead>
					<tbody>
						%for comment in comment_editions:
							%if comment_editions[comment]:
								<tr>
									<td>{{comment[0]}}</td>
									<td>
										%for edition in comment_editions[comment]:
											<p>{{edition[2]}}</p>
										%end
									</td>
								</tr>
							%end
						%end
					</tbody>
				</table>
			</div>
		</div>
	</div>
</body>
</html>