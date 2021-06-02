/// @func array_simple_search
/// @param {array}	array	The array to search
/// @param {mixed}	value	The value to find
/// @desc Searches for the first occurance of value in the array, and returns that position.  If the
///		value is not found, ValueNotFound will be thrown.  If an array is not provided, InvalidArgumentType
///		will be thrown.
/// @example
//var _contains	= array_simple_search( [ "eggs", "bread", "milk" ], "bread" );
//
//show_debug_message( _contains );
/// @throws InvalidArgumentType, ValueNotFound
/// @returns Array
/// @wiki Core-Index Functions
function array_simple_search( _array, _value ) {
	if ( is_array( _array ) == false ) { throw new InvalidArgumentType( "array_simple_search", 0, _array, "array" ); }
	
	var _i = 0; repeat( array_length( _array ) ) {
		if ( _array[ _i++ ] == _value ) { return _i - 1; }
		
	}
	throw new ValueNotFound( "array_simple_search", _value );
	
}
