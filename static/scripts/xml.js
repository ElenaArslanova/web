var xml_requested = false;

function download_xml(event) {
	$('#xml').css('text-decoration', 'none');
	if (xml_requested == false) {
		$('#xml').removeAttr('href');
		$('#xml').removeAttr('download');
		ajax.get('/load_xml', {}, function(response) {
			$('#xml').attr('href', response);
			$('#xml').attr('download', response);
			$('#xml > span').text('Скачать xml');
			xml_requested = true;
		});
	}
	else {
		$('#xml > span').text('Комментарии в xml');
		xml_requested = false;
	}
}