/// @fun array string_explode_reverse
/// @param {string}	string	the string to explode
/// @param {string}	divider	the character(s) to use to break up the string
/// @param {bool}	trim	whether to trim whitespace from each item
/// @desc	takes a string, and converts it into an array based on the specified divider
function string_explode_reverse( _string, _divider, _trim ) {
	var _array	= array_create( string_count( _divider, _string ) + 1 );
	var _sep	= string_length( _divider );
	var _len	= string_length( _string );
	var _last	= 1;
	var _next;
	
	var _i = array_length( _array ) - 1; repeat ( array_length( _array ) - 1 ) {
		_next	= string_pos_ext( _divider, _string, _last );
		_array[ _i-- ]	= ( _trim ? string_trim( string_copy( _string, _last, _next - _last ) ) : string_copy( _string, _last, _next - _last ) );
		
		_last	= _next + _sep;
		
	}
	_array[ _i ]	= ( _trim ? string_trim( string_copy( _string, _last, _len - _last + 1 ) ) : string_copy( _string, _last, _len - _last + 1 ) );
	
	return _array;
	
}
