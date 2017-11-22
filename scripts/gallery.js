class Gallery{
	constructor(){
		this.items = document.getElementsByClassName('gallery-img')
		this.item_id_to_index = {}
		for (var i = 0; i < this.items.length; i++) {
			this.item_id_to_index[this.items[i].id] = i;
		this.current_index = -1;
		this.image_opened = false;
		}
	}

	getNeighbours(item_index){
		if (item_index == 0)
			return [this.items[this.items.length - 1], this.items[1]];
		if (item_index == this.items.length - 1)
			return [this.items[item_index - 1], this.items[0]];
		return [this.items[item_index - 1], this.items[item_index + 1]];
	}

	showImage(index){
		var image = this.items[index];
		this.image_opened = true;
		this.current_index  = index;
		processModal('modal-window', false);
		document.getElementById('modal-img').src = image.src;
	}

	showNextImage(direction){
		var neighbours = this.getNeighbours(this.current_index);
		var next_image = direction > 0 ? neighbours[1] : neighbours[0];
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
		var items = document.getElementsByClassName('gallery-img');
		var loaded = []
		for (var i = 0; i < items.length; i++){
			if (items[i].complete && items[i].naturalHeight > 1)
				loaded.push(items[i]);	
		}
		for (var i = 0; i < loaded.length; i++)
			loaded[i].style.background = 'none';
		if (loaded.length == items.length)
			clearInterval(loading_interval);
	}, 1000);
}

var gallery = new Gallery();
var show_help = false;