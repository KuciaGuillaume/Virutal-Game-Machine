

// IF TAG

if (TAG == "ON_BACKGROUNDS") {
	var scroll_bar = GetObject("SCROLL_IMAGE_BAR");
	var backgrounds = GetObject("GUI_SELECT_BACKGROUNDS");
	if (scroll_bar == undefined || backgrounds == undefined)
		return;
	draw_set_alpha(scroll_bar.image_alpha);
	var X = backgrounds.x; var Y = backgrounds.y;
	draw_rectangle(X, Y, X + backgrounds.sprite_width, Y + backgrounds.IMAGE_HEIGHT, true);
}

