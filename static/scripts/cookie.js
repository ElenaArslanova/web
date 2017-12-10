function setCookie(name, value){
	document.cookie = name + '=' + value + ';';
}

function getCookie(name){
	var cookies = decodeURIComponent(document.cookie);
	var cookie_regexp = new RegExp(name + '=([0-9a-zA-z./:-]+);?(expires=([a-zA-Z0-9;,: ]+);?)?(path=([a-zA-Z0-9\/]+))?');
	var match = cookies.match(cookie_regexp);
	if (match != null)
		return {'value' : match[1], 'expires' : match[2], 'path' : match[3]};
	return null;
}

function deleteCookie(name){
	document.cookie = name + '=; expires=Thu, 01 Jan 1970 00:00:01 GMT;';
}