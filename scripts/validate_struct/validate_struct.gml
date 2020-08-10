/// @func validate_struct
/// @param value
/// @param type
/// @param critical?
/// @param output
function validate_struct( _value, _type, _critical, _output ){
	_value	= instanceof( _value );
	
	if ( is_undefined( _value ) || ( string_char_at( _type, 1 ) == "*" ? string_pos( string_delete( _value, 1, 1 ), _value ) == 1 : _type != _value ) ) {
		if ( _critical ) {
			throw( _output );
			
		} else if ( _output != undefined ) {
			log_nonfatal( _output );
			
		}
		return false;
		
	}
	return true;
	
}
