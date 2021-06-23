/// @func InputGeneric
/// @desc	An interface for creating new input sources. Contains a single method that is simply used to
//		determine if the control is being activated or not.
/// @wiki Input-Handling-Index
function __InputSource__() constructor {
	/// @desc Returns `true` if this input is being "pressed".
	static down	= function() { return false; } // override
	
}
