/// @func string_explode
/// @param {string}	string	The string to explode
/// @param {string}	divider	The character(s) to use to break up the string
/// @param {bool}	*trim	optional: Whether to trim whitespace from each item
/// @desc	Breaks the input string up based on divider and returns the results as an array.  If
///		trim is true, whitespace will also be trimmed from each element. If a non-string is provided
///		for string or divider, or a non-number for trim, InvalidArgumentType will be thrown.
/// @example
//string_explode( "cat, bat, rat, hat", "," );
/// @output [ "cat","bat","rat","hat" ]
/// @throws InvalidArgumentType
/// @returns array
/// @wiki Core-Index Functions
function string_explode( _string, _divider, _trim ) {
	if ( _string == "" ) { return []; }
	
	if ( is_string( _string ) == false ) { throw new InvalidArgumentType( "string_explode", 0, _string, "string" ); }
	if ( is_string( _divider ) == false ) { throw new InvalidArgumentType( "string_explode", 1, _divider, "string" ); }
	
	if ( _trim == undefined ) { _trim = false; }
	
	if ( is_numeric( _trim ) == false ) { throw new InvalidArgumentType( "string_justify", 2, _trim, "bool" ); }
	
	var _array	= array_create( string_count( _divider, _string ) + 1 );
	var _sep	= string_length( _divider );
	var _len	= string_length( _string );
	var _last	= 1;
	var _next;
	
	var _i = 0; repeat ( array_length( _array ) - 1 ) {
		_next	= string_pos_ext( _divider, _string, _last - 1 );
		_array[ _i++ ]	= ( _trim ? string_trim( string_copy( _string, _last, _next - _last ) ) : string_copy( _string, _last, _next - _last ) );
		
		_last	= _next + _sep;
		
	}
	_array[ _i ]	= ( _trim ? string_trim( string_copy( _string, _last, _len - _last + 1 ) ) : string_copy( _string, _last, _len - _last + 1 ) );
	
	return _array;
	
}
