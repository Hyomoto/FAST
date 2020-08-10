/// @func MouseWheel
/// @param constant
function MouseWheel( _constant ) : GenericInput( _constant ) constructor {
	static down	= function() {
		return ( constant == mb_wheel_up ? mouse_wheel_up() : mouse_wheel_down() );
		
	}
	
}
#macro mb_wheel_up		0
#macro mb_wheel_down	1
