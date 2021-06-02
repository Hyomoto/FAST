/// @func array_insertion_sort
/// @param    {array}    array            The array to sort
/// @param    {mixed}    *sort_or_func    Whether or not to sort ascending, or a function to use instead.
/// @desc	Sorts the provided array using insertion sort.  If an array is not provided or an invalid
///		value for sort_or_func is provided, InvalidArgumentType will be thrown.
/// @throws InvalidArgumentType
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
