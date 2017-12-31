%for comment in comments:
	<li>
		<div class="container-fluid">
			<div class="row">
				<div class="col-xs-6 username">
					<p>{{comment.get('user')}}</p>
				</div>
				<div id="edit-{{photo_id}}-{{comment.get('id')}}" class="col-xs-6 text-right">
					{{!'<i class="fa fa-pencil" onclick="edit_comment(event)"></i>' if comment.get('can_edit') else ""}}
				</div>
			</div>
		</div>
		<div id="comment-{{comment.get('id')}}" class="comment-text">
			<p id="content-{{comment.get('id')}}">{{comment.get('text')}}</p>
			<p class="date sub-text text-right">{{comment.get('date')}}</p>
		</div>
	</li>