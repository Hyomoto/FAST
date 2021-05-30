x	+= 1;
y	+= 0.5;

var _scroll	= mouse_wheel_up() - mouse_wheel_down();

if ( _scroll != 0 ) {
	start	= max( start + _scroll, 0 );
	surface.redraw	= true;
	
}