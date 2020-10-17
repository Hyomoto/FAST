/// @func array_contains
/// @param {array}	array
/// @param {mixed}	value
/// @desc Returns the index of the first found instance of `value` in `array`.  If it does not exist,
//		returns `-1` instead.
/// @example
//var _contains	= array_contains( [ "eggs", "bread", "milk" ], "bread" );
//
//show_debug_message( _contains );
/// @returns array
/// @wiki Core-Index Functions
function array_contains( _array, _value ) {
	var _i = 0; repeat( array_length( _array ) ) {
		if ( _array[ _i++ ] == _value ) { return _i - 1; }
		
	}
	return -1;
	
}
