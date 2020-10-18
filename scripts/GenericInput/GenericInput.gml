/// @func GenericInput
/// @desc	An interface for creating new input sources. Contains a single method that is simply used to
//		determine if the control is being activated or not.
/// @wiki Input-Handling-Index
function GenericInput() constructor {
	/// @desc Returns `true` if this input is being "pressed".
	static down	= function() {
		return false;
		
	}
	static is	= function( _data_type ) {
		return _data_type == GenericInput;
		
	}
	
}
