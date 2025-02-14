
function MouseInside(left, right, top, bottom) {
	
	if (mouse_x >= left && mouse_x <= right && mouse_y >= top && mouse_y <= bottom)
		return true;
	return false;
}

function MouseInsideObject(OBJECT) {
	
	if (mouse_x >= OBJECT.bbox_left && mouse_x <= OBJECT.bbox_right && mouse_y >= OBJECT.bbox_top && mouse_y <= OBJECT.bbox_bottom)
		return true;
	return false;
}


function MouseInsideRound(OBJECT) {
	
	if (!OBJECT.OTHER_DRAWING)
		return MouseInside(OBJECT.x, OBJECT.x + OBJECT.SIZE_X, OBJECT.y, OBJECT.y + OBJECT.SIZE_Y);
	else {
		var X = OBJECT.x + OBJECT.OTHER_DRAWING_X;
		var Y = OBJECT.y + OBJECT.OTHER_DRAWING_Y;
		return MouseInside(X, X + OBJECT.SIZE_X, Y, Y + OBJECT.SIZE_Y);
	}
}
