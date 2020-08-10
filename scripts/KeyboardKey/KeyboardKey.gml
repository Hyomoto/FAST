/// @func KeyboardKey
/// @param constant
function KeyboardKey( _constant ) : GenericInput( _constant ) constructor {
	static down	= function() {
		return keyboard_check( constant );
		
	}
	if ( is_string( constant ) ) {
		constant	= ord( constant );
		
	}
	
}
