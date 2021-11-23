/// @func GamepadAxis
/// @param {int/string}	constant	Must be a gamepad axis input
/// @desc	Converts Gamepad Axis' into a format used by (#InputDevice).
/// @wiki Input-Handling-Index Gamepad
function GamepadAxis( _constant ) : __InputSource__() constructor {
	static down	= function() {
		return __Constant();
		
	}
	__Constant	= _constant;
	
}
