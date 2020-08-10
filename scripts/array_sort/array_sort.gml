/// @func array_sort
/// @param array	- the array to be sorted
/// @param start	- the indice to start sorting at
/// @param end		- the last indice to sort
/// @param ascending?	- whether the sort should be ascending or descending
/// @param *pivot	- used to override the comparison used in the pivot, has format function( _value )
/// @param *compare	- used to override the comparison used when sorting, has format function( _pivot, _value, _ascending )
function array_sort( _array, _start, _end, _ascending, _pivot, _compare ) {
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
	
	array_sort( _array, _start, _i - 1, _ascending, _pivot, _compare );
	array_sort( _array, _i + 1, _end, _ascending, _pivot, _compare );
	
}
