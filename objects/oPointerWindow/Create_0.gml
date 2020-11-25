resize		= function( _w, _h ) {
	surface.resize( _w, _h );
	interior.resize( _w - 2, _h - 16 );
	
	interface.width	= _w + 2;
	interface.height= _h + 2;
	
	interfaceGrab.shape.w	= _w;
	interfaceGrab.shape.h	= 30;
	
	interfaceResize.shape.x	= interface.width - 4;
	interfaceResize.shape.y	= interface.height - 4;
	
	interfaceClose.shape.x	= _w - 32;
	interfaceClose.shape.y	= 4;
	
	interfaceMinimize.shape.x	= _w - 64;
	interfaceMinimize.shape.y	= 4;
	
}
render		= new RenderStack();
surface		= new Surface( 1, 1 );
interface	= new PointerStack( 0, 0, 1, 1 );
interior	= new Surface( 1, 1 );

dragOffset	= undefined;

interfaceGrab	= interface.add( new PointerSimpleMouse( new ShapeRectangle( 0, 0, 0, 0 ) ) );
interfaceGrab.onEnter	= function() {
	window_set_cursor( cr_drag );
	
}
interfaceGrab.onLeave	= function() {
	window_set_cursor( cr_default );
	
}
interfaceGrab.onDown	= function( _x, _y ) {
	interface.hold	= interfaceGrab;
	dragOffset		= { x : x - mouse_x, y : y - mouse_y }
	
}
interfaceGrab.onUp = function( _x, _y ) {
	interface.hold = undefined;
	
}

interfaceClose		= interface.add( new PointerSimpleMouse( new ShapeRectangle( 0, 0, 24, 24 ) ) );
interfaceMinimize	= interface.add( new PointerSimpleMouse( new ShapeRectangle( 0, 0, 24, 24 ) ) );

interfaceResize	= interface.add( new PointerSimpleMouse( new ShapeRectangle( 0, 0, 5, 5 ) ) );
interfaceResize.onEnter	= function() {
	window_set_cursor( cr_size_nwse );
	
}
interfaceResize.onLeave	= function() {
	window_set_cursor( cr_default );
	
}
interfaceResize.onDown	= function( _x, _y ) {
	interface.hold = interfaceResize;
	
}
interfaceResize.onUp = function( _x, _y ) {
	interface.hold = undefined;
	
	resize( max( POINTER_WINDOW_MINIMUM_WIDTH, mouse_x - x + 1 ), max( POINTER_WINDOW_MINIMUM_HEIGHT, mouse_y - y + 1 ) );
	
}

resize( bbox_right - bbox_left + 1, bbox_bottom - bbox_top + 1 );

#macro POINTER_WINDOW_MINIMUM_WIDTH		80
#macro POINTER_WINDOW_MINIMUM_HEIGHT	80
