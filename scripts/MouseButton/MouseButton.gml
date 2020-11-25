/// @func MouseButton
/// @param {int}	constant	One of the `mb_` constants to check for.
/// @desc	Converts mouse inputs into a format used by (#InputDevice).
/// @wiki Input-Handling-Index Mouse
function MouseButton( _constant ) : InputGeneric( _constant ) constructor {
	static down	= function() {
		return mouse_check_button( constant );
		
	}
	/// @desc The mouse button to check for inputs.
	constant	= _constant;
	
}
