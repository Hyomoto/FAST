/// @func InputMethod
/// @params {func}	method	The method to bind to this input.
/// @desc	Used to bind unconventional input sources to an InputDevice.
function InputMethod( _method ) : __InputSource__() constructor {
	/// @desc Returns `true` if this input is being "pressed".
	down	= _method;
	
}
