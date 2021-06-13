/// @func string_trim
/// @param {string} string	The string to trim
/// @param {string} *chars	optional: The characters to trim
/// @desc	Trims unwanted characters from the left and right sides of the string.  If chars is not
///		specified tabs and spaces(whitespace) will be removed.  If string or chars is not a string,
///		InvalidArgumentType will be thrown.
/// @example
//string_trim( "	  Hello World!		" );
/// @output "Hello World!"
/// @throws InvalidArgumentType
/// @returns string
/// @wiki Core-Index Functions
function string_trim( _string, _chars ) {
	if ( is_string( _string ) == false ) { throw new InvalidArgumentType( "string_trim", 0, _string, "string" ); }
	
	if ( _chars == undefined ) { _chars = " \t"; }
	
	if ( is_string( _chars ) == false ) { throw new InvalidArgumentType( "string_trim", 1, _chars, "string" ); }
	
	var _start	= 0;
	var _end	= string_length( _string );
	
	repeat ( _end ) {
		if ( not string_pos( string_char_at( _string, ++_start ), _chars ) )
			break;
		
	}
	repeat ( _end ) {
		if ( not string_pos( string_char_at( _string, _end ), _chars ) )
			break;
			
		_end--;
		
	}
	return string_copy( _string, _start, _end - ( _start - 1 ) );
	
}
