/// @func array_combine
/// @param {array}	arrays...
/// @desc	Combines the provided arrays into a single one and returns it.  If an a value other than
///		an array is provided, InvalidArgumentType will be thrown.
/// @example
//var _concat = array_combine( [ 10, 20 ], [ "a, "b" ] );
//
//show_debug_message( _concat );
/// @throws InvalidArgumentType
/// @returns Array
/// @wiki Core-Index Functions
function array_combine() {
	var _size	= 0;
	
	var _i = 0; repeat( argument_count ) {
		_size	+= array_length( argument[ _i++ ] );
		
	}
	var _array	= array_create( _size );
	var _last	= 0;
	
	var _i = 0; repeat( argument_count ) {
		if ( is_array( argument[ _i ] ) == false ) { throw new InvalidArgumentType( "array_combine", _i, argument[ _i ], "array" ); }
		
		array_copy( _array, _last, argument[ _i ], 0, array_length( argument[ _i ] ) );
		
		_last	= array_length( argument[ _i ] );
		
		++_i;
		
	}
	return _array;
	
}
