/// @func array_to_string
/// @param {array}	array	
/// @param {string}	divider	optional: The string to use to divide entries.  Default: " "
/// @desc Returns the entries in the given array converted to a string, with `divider` separating them.
/// @returns string
/// @wiki Core-Index Functions
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
