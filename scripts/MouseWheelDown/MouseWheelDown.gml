/// @func MouseWheelDown
/// @desc	Converts scrolling the mouse wheel down into a format used by (#InputDevice).
/// @wiki Input-Handling-Index Mouse
function MouseWheelDown() : InputGeneric() constructor {
	static down	= function() {
		return mouse_wheel_down();
		
	}
	
}
