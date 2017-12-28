var background = getCookie('mainpage_background');
if (background != null)
	document.getElementById('home').style.background = 'url(' + "'" + background.value + "'" + ') no-repeat center center fixed';

String.prototype.hashCode = function() {
    var hash = 0;
    if (this.length == 0) {
        return hash;
    }
    for (var i = 0; i < this.length; i++) {
        char = this.charCodeAt(i);
        hash = ((hash<<5)-hash)+char;
        hash = hash & hash; // Convert to 32bit integer
    }
    return hash;
}

function convert() {
	document.log.password.value = document.log.password.value.hashCode();
	return true; 
}

$(document).ready(function(){
	$("#registration-form").hide();
	$("#login-form").hide();

	$('#nav-login').click(function(){
		document.getElementById('modal-form').style.display='block';
		$("#registration-form").hide();
		$("#login-form").fadeIn(500);
	});
});

$("#reg-option").click(function(){
	$("#login-form").fadeOut(200);
	$("#registration-form").delay(300).fadeIn(500);
});

$("#log-option").click(function(){
	$("#registration-form").fadeOut(200);
	$("#login-form").delay(300).fadeIn(500);
});

document.getElementById('screen').textContent += " " + window.screen.width+"x"+window.screen.height + ' px';