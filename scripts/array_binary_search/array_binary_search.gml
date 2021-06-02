/// @func array_binary_search
/// @param {Array}	array	The array to search
/// @param {Mixed}	value	The value to find
/// @desc	Performs a binary search on the given array for the specified value.  The array must
///		be sorted for binary search to work.  You can adjust the function used for comparison by
///		specifying function.  If an array or method are not provided, InvalidArgumentType will be
///		thrown.  If the value is not found, ValueNotFound is thrown.
/// @throws InvalidArgumentType, ValueNotFound
function array_binary_search( _array, _value, _func ) {
	if ( is_array( _array ) == false ) { throw new InvalidArgumentType( "array_binary_search", 0, _array, "array" ); }
	
	if ( _func == undefined ) { _func = function( _a, _b ) { return _a == _b ? 2 : _a > _b; }}
	
	if ( is_method( _func ) == false ) { throw new InvalidArgumentType( "array_binary_search", 2, _func, "method" ); }
	
	var _l	= 0;
	var _h	= array_length( _array );
	
	while ( _l <= _h ) {
		var _m	= ( _l + _h ) div 2;
		var _g	= _array[ _m ];
		
		switch ( _func( _g, _value ) ) {
			case 0 : _l = _m + 1; break;
			case 1 : _h = _m - 1; break;
			default: return _m;
			
		}
		
	}
	throw new ValueNotFound( "binary_search", _value );
	
}
