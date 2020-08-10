/// @func MouseButton
/// @param constant
function MouseButton( _constant ) : GenericInput( _constant ) constructor {
	static down	= function() {
		return mouse_check_button( constant );
		
	}
	
}
