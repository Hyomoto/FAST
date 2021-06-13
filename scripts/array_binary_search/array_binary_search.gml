/// @func array_binary_search
/// @param {Array}	array	The array to search
/// @param {Mixed}	value	The value to find
/// @param {method}	*func	optional: If provided, will be used for sake of comparison
/// @desc	Uses a binary search on the given array to find the position of value.  The array must
///		be sorted for binary search to work, otherwise results will be inconsistent.   You can
///		override the function used for comparison by specifying func. If the value is not found,
///		ValueNotFound will be returned.  If an array is not provided to search, or a method is not
///		provided for func InvalidArgumentType will be thrown.
/// @throws InvalidArgumentType
/// @returns Mixed or ValueNotFound
/// @example
//array_binary_search( [ 10, 20, 30, 40, 50 ], 40 );
/// @output 3
/// @wiki Core-Index Functions
function array_binary_search( _array, _value, _f ) {
	if ( is_array( _array ) == false ) { throw new InvalidArgumentType( "array_binary_search", 0, _array, "array" ); }
	
	if ( _f == undefined ) { _f = function( _a, _b ) { return _a == _b ? 2 : _a > _b; }}
	
	if ( is_method( _f ) == false ) { throw new InvalidArgumentType( "array_binary_search", 2, _f, "method" ); }
	
	var _l	= 0;
	var _h	= array_length( _array );
	
	while ( _l <= _h ) { 
		var _m	= ( _l + _h ) div 2;
		var _g	= _array[ _m ];
		
		switch ( _f( _g, _value ) ) {
			case 0 : _l = _m + 1; break;
			case 1 : _h = _m - 1; break;
			default: return _m;
			
		}
		
	}
	return new ValueNotFound( "binary_search", _value, _m );
	
}
