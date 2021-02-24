/// @func string_trim
/// @param {string} string	the string to trim
/// @param {string} *trim	optional: the characters to trim
/// @desc	trims the whitespace, tabs and spaces, before and after a string
/// @returns string
/// @wiki Core-Index Functions
function string_trim( _string, _trim ) {
	var _value	= string( _string );
	var _start	= 0;
	var _end	= string_length( _value );
	
	if ( _trim == undefined ) { _trim = " \t"; }
	
	repeat ( _end ) {
		if ( not string_pos( string_char_at( _value, ++_start ), _trim ) ) {
			break;
			
		}
		
	}
	repeat ( _end ) {
		if ( not string_pos( string_char_at( _value, _end ), _trim ) ) {
			break;
			
		}
		_end--;
		
	}
	return string_copy( _string, _start, _end - ( _start - 1 ) );
	
}
