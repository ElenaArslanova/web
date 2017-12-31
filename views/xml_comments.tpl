<?xml version="1.0" encoding="UTF-8"?>
<photos>
	%for id, photo in info.items():
		<photo>
			<id>{{id}}</id>
			<img>{{photo.get('img')}}</img>
			<comments>
				%for comment in photo.get('comments'):
					<comment>
						<id>{{comment[0]}}</id>
						<author>{{comment[3]}}</author>
						<date>{{comment[2]}}</date>
						<text>{{comment[1]}}</text>
					</comment>
				%end
			</comments>
		</photo>
	%end
</photos>