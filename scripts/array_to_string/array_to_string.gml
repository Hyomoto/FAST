/// @func array_to_string
/// @param {array}	array		The array to convert 
/// @param {string}	*divider	The divider to use, default: " "
/// @desc	Returns the entries in array converted to a string using `divider` to separate them.  If an
///		array is not provided or the divider is not a string, InvalidArgumentType will be thrown.
/// @throws InvalidArgumentType
/// @returns string
/// @wiki Core-Index Functions
function array_to_string( _array, _divider ){
	if ( is_array( _array ) == false ) { throw new InvalidArgumentType( "array_to_string", 0, _array, "array" ); }
	
	if ( _divider == undefined ) { _divider = " "; }
	
	if ( is_string( _divider ) == false ) { throw new InvalidArgumentType( "array_to_string", 1, _divider, "string" ); }
	
	var _string	= "";
	
	var _i = 0; repeat( array_length( _array ) ) {
		if ( _i > 0 ) { _string += _divider }
		_string	+= string( _array[ _i++ ] );
		
	}
	return _string;
	
}
