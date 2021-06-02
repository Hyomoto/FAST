/// @func array_quicksort
/// @param {array}	array		the array to be sorted
/// @param {bool}	ascending?	whether the sort should be ascending or descending
/// @param {func}	*pivot		optional: used to override the comparison used in the pivot
/// @param {func}	*compare	optional: used to override the comparison used when sorting, has format function( _pivot, _value, _ascending )
/// @desc	An array, sort-in-place algorithm. The default pivot is simply the value of the array index,
//		otherwise you can provide a method that will be passed that value and you can choose what it
//		returns. Similarly, the default compare is simply to compare the two values and return which
//		one is larger (if `ascending` is true). However, it can be overridden as well, and is passed
//		the value, pivot value, and `ascending`.  See ArrayString for an example of how to override
//		the pivot and function to change the sort behavior.
/// @example
//var _array	= [ 10, 4, 15, 23, 12, 4 ];
//
//array_quicksort( _array );
/// @wiki Core-Index Functions
function array_quicksort( _array, _ascending, _pivot, _compare ) {
	static __search__	= function( _array, _start, _end, _ascending, _pivot, _compare, _search ) {
		// if the start is equal to or less than the end, abort
		if ( _start >= _end ) { return; }
		// set up the default comparison, if not provided
		_compare	= ( _compare != undefined ? _compare : function( _value, _pivot, _ascending ) {
			return ( _ascending ? _pivot <= _value : _pivot >= _value ) });
		// find the pivot
		var _value	= ( _pivot == undefined ? _array[ _end ] : _pivot( _array[ _end ] ) );
		
		var _i		= _start - 1;
		var _hold;
		
		var _j = _start; repeat( _end - _start ) {
			if ( _compare( _array[ _j ], _value, _ascending ) ) {
				_hold	= _array[ ++_i ];
				
				_array[@ _i ]	= _array[ _j ];
				_array[@ _j ]	= _hold;
				
			}
			++_j;
			
		}
		_hold	= _array[ ++_i ];
		
		_array[@ _i ]	= _array[ _end ];
		_array[@ _end ]	= _hold;
		
		_search( _array, _start, _i - 1, _ascending, _pivot, _compare );
		_search( _array, _i + 1, _end, _ascending, _pivot, _compare );
		
	}
	__search__( _array, 0, array_length( _array ) - 1, _pivot, _compare, __search__ );
	
}
