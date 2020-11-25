/// @func InputMethod
/// @params {func}	method	The method to bind to this input.
/// @desc	Used to bind unconventional input sources to an InputDevice.
function InputMethod( _method ) : InputGeneric() constructor {
	/// @desc Returns `true` if this input is being "pressed".
	static down	= function() {
		return func();
		
	}
	/// @desc the method that will be called to check for status
	func	= _method;
	
}
