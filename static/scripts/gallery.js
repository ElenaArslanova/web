class Modal{
	constructor(id, image=null, button=null, loading_gif=null){
		this.modal = '#' + id;
		this.image = image;
		this.button = button;
		this.loading_gif = loading_gif;
	}

	// set_zoom(zoom){
	// 	if (zoom)
	// 		this.image.style.webkitAnimationPlayState = 'running';
	// 	else
	// 		this.image.style.webkitAnimationPlayState = 'paused';
	// }

	open(){
		if (this.button != null)
			this.button.style.visibility = 'hidden';
		$(this.modal).show();
	}

	show(path){
		this.image.src = path;
		if (this.button != null)
			this.button.style.visibility = 'visible';
	}

	setLoading(){
		if (this.image != null && this.loading_gif != null)
			this.image.src = this.loading_gif;
	}

	close(){
		$(this.modal).hide();
		this.setLoading();
	}
}

class Gallery{
	constructor(){
		this.items = document.getElementsByClassName('gallery-img');
		this.item_id_to_index = {};
		this.hq_image_paths = [];
		this.loaded_hq_images = [];
		var img_modals = []
		for (var i = 0; i < this.items.length; i++) {
			this.item_id_to_index[this.items[i].id] = i;
			this.hq_image_paths[i] = this.items[i].getAttribute('data-src').replace(/thmb_/gi, '');
			this.loaded_hq_images[i] = null;
			img_modals[i] = new Modal('modal-window-' + (i+1), document.getElementById('modal-img-' + (i+1)),
				document.getElementById('modal-button'), this.loading_gif);
			}
		this.current_index = 0;
		this.image_opened = false;
		this.loading_gif = 'images/loading.gif';
		this.modals = {'image': img_modals,
					  'help': new Modal('help-window')};
	}

	addHqImage(index){
		var image = new Image();
		image.src = this.hq_image_paths[index];
		this.loaded_hq_images[index] = image;
	}

	isLoaded(image){
		return image != null && image.complete && image.naturalHeight !== 0;
	}

	getNeighboursIndices(item_index){
		if (item_index == 0)
			return [this.items.length - 1, 1];
		if (item_index == this.items.length - 1)
			return [item_index - 1, 0];
		return [item_index - 1, item_index + 1];
	}

	preloadNextImage(){
		var next_index = this.getNeighboursIndices(this.current_index)[1]; 
		if (this.loaded_hq_images[next_index] == null)
			this.addHqImage(next_index);
	}

	showImage(index, loaded=false){
		var image = this.items[index];
		var modal = this.modals['image'][index];
		this.image_opened = true;
		this.current_index  = index;
		this.preloadNextImage();
		modal.open();
		if (this.loaded_hq_images[index] == null)
			this.addHqImage(index);
		var image_path = gallery.loaded_hq_images[index].src;
		if (!loaded){
			var modal_interval = setInterval(function(){
					if (gallery.isLoaded(gallery.loaded_hq_images[index])){
						modal.show(image_path);
						clearInterval(modal_interval);
					}
			}, 700);
		}
		else
			modal.show(image_path);
	}

	showNextImage(direction){
		var neighbours = this.getNeighboursIndices(this.current_index);
		var next_image_index = direction > 0 ? neighbours[1] : neighbours[0];
		var next_hq_image = this.loaded_hq_images[next_image_index];
		var current_modal = this.modals['image'][this.current_index];
		var next_modal = this.modals['image'][next_image_index];
		current_modal.close();
		if (!this.isLoaded(next_hq_image)){
			next_modal.setLoading();
			this.showImage(next_image_index, false);
		}
		else
			this.showImage(next_image_index, true);
		setHash(this.current_index);
	}
}

function showImage(event){
	var index = gallery.item_id_to_index[event.target.id];
	if (gallery.isLoaded(gallery.loaded_hq_images[index]))
		gallery.showImage(index, true);
	else
		gallery.showImage(index);
	setHash(index);
	// gallery.modals['image'].forEach(function(modal){
	// 	modal.set_zoom(false)
	// });
}

function closeImage(){
	gallery.image_opened = false;
	gallery.modals['image'][gallery.current_index].close();
	clearHash();
	// gallery.modals['image'].forEach(function(modal){
	// 	modal.set_zoom(true)
	// });
}

function showHelp(){
	show_help = true;
	gallery.modals['help'].open();
}

function closeHelp(){
	show_help = false;
	gallery.modals['help'].close();
}

function processKeyDown(event){
	var textarea_focused = $('textarea').is(':focus');
	if  (event.keyCode == 27){
		event.preventDefault ? event.preventDefault() : (event.returnValue = false);
		if (gallery.image_opened)
			closeImage();
		else if (show_help)
			closeHelp();
	}
	else if (event.keyCode == 112 && !show_help){
		event.preventDefault ? event.preventDefault() : (event.returnValue = false);
		showHelp();
		}
	else if (event.keyCode == 37 && gallery.image_opened && !textarea_focused)
		gallery.showNextImage(-1);
	else if (event.keyCode == 39 && gallery.image_opened && !textarea_focused)
		gallery.showNextImage(1);
}

function checkLoading() {
	var loading_interval = setInterval(function(){
		var loaded_count = 0;
		for (var i = 0; i < gallery.items.length; i++){
			var image = gallery.items[i];
			image.src = image.getAttribute('data-src');
			if (gallery.isLoaded(image))
				loaded_count += 1;
		}
		if (loaded_count == gallery.items.length)
			clearInterval(loading_interval);
	}, 700);
}

function checkReloadCookie(){
	var last_shown_image = getCookie('last_shown_image');
	if (last_shown_image != null)
		gallery.showImage(parseInt(last_shown_image.value));
}

function setMainPageBackground(){
	if (getCookie('mainpage_background') != null)
		deleteCookie('mainpage_background');
	setCookie('mainpage_background', gallery.loaded_hq_images[gallery.current_index].src);
}

function setHash(value){
	document.location.hash = value;
}

function getHash(){
	return document.location.hash
}

function clearHash() {
	document.location.hash = '';
}

function edit_comment(event) {
	idxs = event.target.parentElement.id.split('-');
	comment_text = $('#content-'+idxs[2]).html();
	edit_button = '#editbutton-'+idxs[1];
	add_button = '#addbutton-'+idxs[1];
	textarea = '#textarea-'+idxs[1];
	$(textarea).val(comment_text);
	$(textarea).focus();
	$(add_button).hide();
	$(edit_button).show();
	$(document).on('click', edit_button, function(){
		$(edit_button).hide();
		$(add_button).show();
		var edition = $(textarea).val();
		ajax.post('/edit/comment'+idxs[2], {comment:edition}, function(response){
			$('#content-'+idxs[2]).text(edition);
			$(textarea).val('');
		});
	})
}

function send_comment(event) {
	var textarea = event.target.previousElementSibling;
	ajax.post('/comment/img' + event.target.id.split("-")[1], {comment: textarea.value},
		      function(response) {
		      	textarea.value = '';
		      	get_updates();
		      });
}

function get_updates() {
	ajax.get('/update', {}, function(response){
		var result = JSON.parse(response);
		var photos = $('.comment-list');
		var keys = Object.keys(result);
		for (var i = 0; i < keys.length; i++){
			var key = parseInt(keys[i]) - 1;
			var photo = photos[key];
			if (photo.children.length == 0) {
				photo.insertAdjacentHTML('beforeEnd', result[keys[i]]);
			}
			else {
				var last_comment = photo.children[photo.children.length - 1];
				last_comment.insertAdjacentHTML('afterEnd', result[keys[i]]);
			}
		}
	});
}

setInterval(get_updates, 5000);

var gallery;
var show_help;

function init(){
	gallery = new Gallery();
	show_help = false;
	checkReloadCookie();
}

window.onbeforeunload = function reload(){
	if (gallery.image_opened)
		setCookie('last_shown_image', gallery.current_index);
	else if (getCookie('last_shown_image') != null)
		deleteCookie('last_shown_image');
}

window.onpopstate = function(event) {
	var state = getHash();
	if (state !== '' && !isNaN(state.substring(1))){
		var index = parseInt(state.substring(1));
		gallery.showImage(index); 
	}
	else if (state == '')
		gallery.modals['image'][gallery.current_index].close();
}