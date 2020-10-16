/// @func string_trim
/// @param {string} string	the string to trim
/// @desc	trims the whitespace, tabs and spaces, before and after a string
/// @returns string
/// @wiki Core-Index Functions
function string_trim( _string ) {
	var _value	= string( _string );
	var _start	= 0;
	var _end	= string_length( _value );
	var _char;
	
	repeat ( _end ) {
		_char	= string_byte_at( _value, ++_start );
		
		if ( _char != vk_tab && _char != vk_space ) { break }
		
	}
	repeat ( _end ) {
		_char	= string_byte_at( _value, _end );
		
		if ( _char != vk_tab && _char != vk_space ) { break }
		
		_end--;
		
	}
	return string_copy( _string, _start, _end - ( _start - 1 ) );
	
}
