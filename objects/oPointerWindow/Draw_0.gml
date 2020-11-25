if ( surface.update() ) {
	surface.set();
		draw_clear( c_gray );
		
		draw_set_color( c_white );
		
		draw_rectangle( 1, 1, surface.width - 2, 30, false );
		draw_rectangle( 1, 32, surface.width - 2, surface.height - 2, false );
		
		draw_set_color( c_ltgray );
		
		draw_line( 0, 30, surface.width - 2, 30 );
		draw_line( 0, surface.height - 32, surface.width - 2, surface.height - 32 );
		draw_line( 0, surface.height - 2, surface.width - 2, surface.height - 2 );
		
	surface.reset();
	
}
surface.draw( x, y );

draw_sprite( gfx_rect, interfaceMinimize.state == interfaceMinimize.INPUT_NONE ? 3 : 4, x + interfaceMinimize.shape.x, y + interfaceMinimize.shape.y );
draw_sprite( gfx_rect, interfaceClose.state == interfaceClose.INPUT_NONE ? 1 : 2, x + interfaceClose.shape.x, y + interfaceClose.shape.y );

if ( interface.hold == interfaceResize ) {
	draw_set_color( c_ltgray );
	draw_set_alpha( 0.5 );
	
	draw_rectangle( x, y, max( x + 80, mouse_x ), max( y + 80, mouse_y ), false );
	
	draw_set_alpha( 1.0 );
	
}
//interface.draw( x, y, interface.active ? c_green : c_white );

//draw_text( 16, 32, interface.last );