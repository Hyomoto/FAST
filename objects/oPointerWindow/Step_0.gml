interface.update( mouse_x - x, mouse_y - y );

if ( interface.hold == interfaceGrab ) {
	x	= clamp( mouse_x + dragOffset.x, 0, room_width - surface.width );
	y	= clamp( mouse_y + dragOffset.y, 0, room_height- surface.height);
	
}
