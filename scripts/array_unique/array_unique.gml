/// @func array_unique
/// @param {array}	arrays
/// @desc Returns the unique entries in the given array.
/// @example
//var _unique = array_unique( [ 10, 10, 20 ] );
//
//show_debug_message( _unqiue );
/// @returns array
/// @wiki Core-Index Functions
function array_unique( _array ){
	var _hash	= {}
	
	var _i = -1; repeat( array_length( _array ) ) { ++_i;
		_hash[$ string( _array[ _i ] ) ]	= _array[ _i ];
		
	}
	var _list	= variable_struct_get_names( _hash );
	
	_array	= array_create( array_length( _list ) );
	
	var _i = -1; repeat( array_length ( _list ) ) { ++_i;
		_array[ _i ]	= _hash[$ _list[ _i ] ];
		
	}
	return _array;
	
}
