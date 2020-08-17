/// @func array_to_string
/// @param array
/// @param divider
function array_to_string( _array, _divider ){
	if ( is_struct( _array ) ) {
		try {
			return _array.toString( _divider );
			
		} catch ( _ ) {
			return undefined;
			
		}
		
	}
	var _string	= "";
	
	if ( _divider == undefined ) { _divider = " "; }
	
	var _i = 0; repeat( array_length( _array ) ) {
		if ( _i > 0 ) { _string += _divider }
		
		_string	+= string( _array[ _i++ ] );
		
	}
	return _string;
	
}
