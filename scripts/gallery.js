class Gallery{
	constructor(){
		this.items = document.getElementsByClassName('gallery-img')
		this.item_id_to_index = {}
		for (var i = 0; i < this.items.length; i++) {
			this.item_id_to_index[this.items[i].id] = i;
		this.current_index = 0;
		this.image_opened = false;
		}
	}

	getNeighboursIndices(item_index){
		if (item_index == 0)
			return [this.items.length - 1, 1];
		if (item_index == this.items.length - 1)
			return [item_index - 1, 0];
		return [item_index - 1, item_index + 1];
	}

	showImage(index){
		var image = this.items[index];
		this.image_opened = true;
		this.current_index  = index;
		processModal('modal-window', false);
		document.getElementById('modal-img').src = image.src;
	}

	showNextImage(direction){
		var neighbours = this.getNeighboursIndices(this.current_index);
		var next_image_index = direction > 0 ? neighbours[1] : neighbours[0];
		this.showImage(next_image_index);
		if (this.current_index < 0)
			this.current_index = this.items.length - 1;
		else if (this.current_index >= this.items.length)
			this.current_index = 0;
	}
}

function processModal(modal_id, close){
	modal = document.getElementById(modal_id)
	if (close)
		modal.style.display = 'none';
	else
		modal.style.display = 'block';
}

function showImage(event){
	var index = gallery.item_id_to_index[event.target.id];
	gallery.showImage(index);
}

function closeImage(){
	gallery.image_opened = false;
	processModal('modal-window', true);
}

function showHelp(){
	show_help = true;
	processModal('help-window', false);
}

function closeHelp(){
	show_help = false;
	processModal('help-window', true);
}

function processKeyDown(event){
	if  (event.keyCode == 27){
		if (gallery.image_opened)
			closeImage();
		else if (show_help)
			closeHelp();
	}
	else if (event.keyCode == 112 && !show_help)
		showHelp();
	else if (event.keyCode == 37 && gallery.image_opened)
		gallery.showNextImage(-1);
	else if (event.keyCode == 39 && gallery.image_opened)
		gallery.showNextImage(1);
}

function checkLoading() {
	var loading_interval = setInterval(function(){
		var items = document.getElementsByClassName('loading');
		for (var i = 0; i < items.length; i++){
			var image = items[i];
			image.src = image.getAttribute('data-src');
		}
		if (items.length == 0)
			clearInterval(loading_interval);
	}, 1000);
}

function checkReloadCookie(){
	var last_shown_image = getCookie('last_shown_image');
	if (last_shown_image != null)
		gallery.showImage(parseInt(last_shown_image.value));
}

function setMainPageBackground(){
	if (getCookie('mainpage_background') != null)
		deleteCookie('mainpage_background');
	setCookie('mainpage_background', gallery.items[gallery.current_index].src);
}

var gallery = new Gallery();
var show_help = false;
checkReloadCookie();

window.onbeforeunload = function reload(){
	if (gallery.image_opened)
		setCookie('last_shown_image', gallery.current_index);
	else if (getCookie('last_shown_image') != null)
		deleteCookie('last_shown_image');
}