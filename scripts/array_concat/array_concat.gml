/// @func array_concat
/// @param {array}	arrays...
/// @desc Returns the given arrays combined into one.
/// @example
//var _concat = array_concat( [ 10, 20 ], [ "a, "b" ] );
//
//show_debug_message( _concat );
/// @returns array
/// @wiki Core-Index Functions
function array_concat(){
	var _size	= 0;
	
	var _i = 0; repeat( argument_count ) {
		_size	+= array_length( argument[ _i++ ] );
		
	}
	var _array	= array_create( _size );
	var _last	= 0;
	
	var _i = 0; repeat( argument_count ) {
		array_copy( _array, _last, argument[ _i ], 0, array_length( argument[ _i ] ) );
		
		_last	= array_length( argument[ _i ] );
		
		++_i;
		
	}
	return _array;
	
}
