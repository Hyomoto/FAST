/// @func array_quicksort
/// @param {array}	array			An array to sort
/// @param {mixed}	*sort_or_func	optional: The sort logic to use
/// @param {func}	*pivot			optional: A function to retrieve the pivot
/// @desc	A sort-in-place, non-stable sorting algorithm for arrays.  If sort_or_func is true, or not
///		provided, the array will be sorted by ascending value.  Setting this to false will use descending
///		logic.  If a method is provided, this will be used for the comparison.  For complex behaviors, the
///		pivot can also be overriden. If an array is not provided to sort, a non-boolean, non-method is
///		provided to the sort or pivot arguments, InvalidArgumentType will be thrown.
/// @example
//var _array	= [ 10, 4, 15, 23, 12, 4 ];
//
//array_quicksort( _array );
/// @output [ 4,4,10,12,15,23 ]
/// @throws InvalidArgumentType
/// @wiki Core-Index Functions
function array_quicksort( _arr, _sort ) {
	static __search__	= function( _array, _start, _end, _sort, __self__ ) {
		// if the start is equal to or less than the end, abort
		if ( _start >= _end ) { return; }
		// find the pivot
		var _value	= _array[ _end ];
		var _i		= _start - 1;
		var _hold;
		
		var _j = _start; repeat( _end - _start ) {
			if ( _sort( _value, _array[ _j ] ) ) {
				_hold	= _array[ ++_i ];
				
				_array[@ _i ]	= _array[ _j ];
				_array[@ _j ]	= _hold;
				
			}
			++_j;
			
		}
		_hold	= _array[ ++_i ];
		
		_array[@ _i ]	= _array[ _end ];
		_array[@ _end ]	= _hold;
		
		__self__( _array, _start, _i - 1, _sort, __self__ );
		__self__( _array, _i + 1, _end, _sort, __self__ );
		
	}
	if ( is_array( _arr ) == false )
		throw new InvalidArgumentType( "array_quicksort", 0, _arr, "array" );
		
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
	if ( is_method( _sort ) == false ) { throw new InvalidArgumentType( "array_quicksort", 1, _sort, "method" ); }
	
	__search__( _arr, 0, array_length( _arr ) - 1, _sort, __search__ );
	
}
