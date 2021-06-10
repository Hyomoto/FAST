/// @func array_unique
/// @param {array}	array
/// @desc	Returns a new array that contains the unique elements of `array`.  If an array is not
///		provided, InvalidArgumentType will be thrown.
/// @example
//array_unique( [ 10, 10, 20, 20, 30 ] );
/// @output [ 10,20,30 ]
/// @returns array
/// @throws InvalidArgumentType
/// @wiki Core-Index Functions
function array_unique( _array ){
	if ( is_array( _array ) == false ) { throw new InvalidArgumentType( "array_unique", 0, _array, "array" ); }
	
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
