/// @func MouseButton
/// @param constant
/// @wiki Input-Handling-Index
function MouseButton( _constant ) : GenericInput( _constant ) constructor {
	static down	= function() {
		return mouse_check_button( constant );
		
	}
	
}
