/// @func validate_array
/// @param value
/// @param size
/// @param critical?
/// @param output
function validate_array( _value, _size, _critical, _output ){
	if ( is_array( _value ) == false || ( _size > -1 && array_length( _value ) != _size ) ) {
		if ( _critical ) {
			throw( _output );
			
		} else if ( _output != undefined ) {
			log_nonfatal( _output );
			
		}
		return false;
		
	}
	return true;
	
}
