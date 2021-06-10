/// @func array_insertion_sort
/// @param {array}	array			An array to sort
/// @param {mixed}	*sort_or_func	optional: The sort logic to use
/// @desc	A sort-in-place, stable algorithm for arrays.  While less efficient than quick or merge sort,
///		can be very efficient on small arrays due to its simple code. If sort_or_func is true, or not
///		provided, the array will be sorted by ascending value.  Setting this to false will use descending
///		logic.  If a method is provided, this will be used for the comparison.  If an array is not provided
///		to sort, or a non-boolean, non-method is provided for sort, InvalidArgumentType will be thrown.
/// @example
//var _array	= [ 10, 4, 15, 23, 12, 4 ];
//
//array_insertion_sort( _array );
/// @output [ 4,4,10,12,15,23 ]
/// @throws InvalidArgumentType
/// @wiki Core-Index Functions
function array_insertion_sort( _array, _sort_or_func ) {
	if ( is_array( _array ) == false ) { throw new InvalidArgumentType( "array_shuffle", 0, _array, "array" ); }
	
    switch ( _sort_or_func ) {
        case undefined :
        case true : _sort_or_func = function( _a, _b ) { return _a > _b }; break;
        case false: _sort_or_func = function( _a, _b ) { return _a < _b }; break;
        
    }
	if ( is_method( _sort_or_func ) == false ) { throw new InvalidArgumentType( "array_binary_search", 1, _sort_or_func, "method" ); }
	
	var _i = -1; repeat( array_length( _array ) ) { ++_i;
        var key = _array[ _i ];
        var _j = _i - 1;
        
        while ( _j >= 0 && _sort_or_func( _array[ _j ], key )) {
            _array[@ _j + 1] = _array[@ _j];
            _j = _j - 1;
			
        }
        _array[@ _j + 1] = key;
		
    }
    
}
