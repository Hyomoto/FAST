/// @func string_find_first
/// @param {string}	chars		A string of characters to search for
/// @param {string}	string		The string to search
/// @param {int}	*start_at	optional: The position to start the search
/// @desc	Searches the given array for the first occurance of the given characters and returns
///		that position.  If a non-string is provided for chars or string, or start_at is not a number,
///		InvalidArgumentType will be thrown.  If start_at is outside of the bounds of the string,
///		IndexOutOfBounds will be thrown.
/// @example
//string_find_first( "abc", "the cat broke the vase" );
/// @output 5 (the position of the first c)
/// @throws InvalidArgumentType, IndexOutOfBounds
/// @returns string
/// @wiki Core-Index Functions
function string_find_first( _chars, _string, _start ) {
	if ( is_string( _chars ) == false ) { throw new InvalidArgumentType( "string_find_first", 0, _chars, "string" ); }
	if ( is_string( _string ) == false ) { throw new InvalidArgumentType( "string_find_first", 1, _string, "string" ); }
	if ( _chars == "" ) { throw new BadValueFormat( "string_find_first", "string", "An empty string was provided for chars." ); }
	
	if ( _start == undefined ) { _start = 0; }
	
	if ( is_numeric( _start ) == false ) { throw new InvalidArgumentType( "string_find_first", 2, _start, "integer" ); }
	
	if ( _start < 0 || _start >= string_length( _string ) ) { throw new IndexOutOfBounds( "string_find_first", _start, string_length( _string )); }
	
	var _found = 0;
	var _next;
	
	var _i = 0; repeat ( string_length( _chars ) ) {
		_next	= string_pos_ext( string_char_at( _chars, ++_i ), _string, _start );
		
		if ( _next > 0 && ( _next < _found || _found == 0 ) ) {
			_found	= _next;
			
		}
		
	}
	return _found;
	
}
