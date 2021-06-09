/// @func array_union
/// @param {array}	arrays...
/// @desc Returns the unique entries of the given arrays combined into one.
/// @example
//var _union = array_union( [ 10, 20 ], [ 10, 20, 30 ] );
//
//show_debug_message( _union );
/// @returns array
/// @wiki Core-Index Functions
function array_union() {
	var _hash	= {}
	
	var _i = 0; repeat( argument_count ) {
		var _array	= argument[ _i++ ];
		
		var _j = -1; repeat( array_length( _array ) ) { ++_j;
			_hash[$ string( _array[ _j ] ) ]	= _array[ _j ];
			
		}
		
	}
	var _list	= variable_struct_get_names( _hash );
	var _array	= array_create( array_length( _list ) );
	
	var _i = -1; repeat( array_length ( _list ) ) { ++_i;
		_array[ _i ]	= _hash[$ _list[ _i ] ];
		
	}
	return _array;
	
}
