class Gallery{
	constructor(){
		this.items = document.getElementsByClassName('gallery-img')
		this.item_id_to_index = {}
		for (var i = 0; i < this.items.length; i++) {
			this.item_id_to_index[this.items[i].id] = i;
		}
	}

	getNeighbours(item_index){
		if (item_index == 0)
			return [this.items[this.items.length - 1], this.items[1]];
		if (item_index == this.items.length - 1)
			return [this.items[item_index - 1], this.items[0]];
		return [this.items[item_index - 1], this.items[item_index + 1]];
	}
}

function showImage(event){
	var index = gallery.item_id_to_index[event.target.id];
	var image_item = gallery.items[index];
	var neighbours = gallery.getNeighbours(index);
	document.getElementById('modal-window').style.display = 'block';
	document.getElementById('modal-img').src = image_item.src;
}

function closeImage(){
	document.getElementById('modal-window').style.display = 'none';
}

function processKeyDown(event){
	if (document.getElementById('modal-window').style.display == 'block'){
		if (event.keyCode == 27)
			closeImage();
	}
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
			loaded[i].parentNode.style.background = 'none';
		if (loaded.length == items.length)
			clearInterval(loading_interval);
	}, 1000);
}