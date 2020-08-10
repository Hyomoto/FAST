/// @func PointerDevice
/// @desc	behaves as a mouse by default, but can be inherited or overriden to use other
///		input sources.
function PointerDevice() : InputDevice() constructor {
	static get_x	= function() {
		return mouse_x;
		
	}
	static get_y	= function() {
		return mouse_y;
		
	}
	static toString	= function() {
		return string( get_x() ) + ", " + string( get_y() );
		
	}
	inputs	= array_create( argument_count );
	target	= noone;
	event	= undefined;
	
	var _i = 0; repeat( argument_count ) {
		add_input( argument[ _i ], _i );
		
		++_i;
		
	}
	
}
