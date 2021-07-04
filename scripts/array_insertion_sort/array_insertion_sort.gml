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
function array_insertion_sort( _arr, _sort ) {
	static __sort__	= function( _arr, _sort ) {
		var _i = -1; repeat( array_length( _arr ) ) { ++_i;
	        var key = _arr[ _i ];
	        var _j = _i - 1;
        
	        while ( _j >= 0 && _sort( _arr[ _j ], key ) > 0 ) {
	            _arr[@ _j + 1] = _arr[@ _j];
	            _j = _j - 1;
				
	        }
	        _arr[@ _j + 1] = key;
			
	    }
		
	}
	if ( is_array( _arr ) == false )
		throw new InvalidArgumentType( "array_insertion_sort", 0, _arr, "array" );
		
	if ( array_length( _arr ) < 2 )
		return;
	
	if ( struct_type( _sort, Sort )) {
		_sort	= _sort.func();
		
	} else {
		switch ( _sort ) {
	        case undefined :
	        case true : _sort = function( _a, _b ) { return _a > _b ? 1 : -1; }; break;
	        case false: _sort = function( _a, _b ) { return _a < _b ? 1 : -1; }; break;
			
	    }
		
	}
	if ( is_method( _sort ) == false ) { throw new InvalidArgumentType( "array_insertion_sort", 1, _sort, "method" ); }
	
    __sort__( _arr, _sort );
	
}
