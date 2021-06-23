/// @func MouseWheelUp
/// @desc	Converts scrolling the mouse wheel up into a format used by (#InputDevice).
/// @wiki Input-Handling-Index Mouse
function MouseWheelUp() : __InputSource__() constructor {
	static down	= function() {
		return mouse_wheel_up();
		
	}
	
}
