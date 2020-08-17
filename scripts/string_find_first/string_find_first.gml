/// @func string_find_first( chars, string, start )
/// @param chars
/// @param string
/// @param start
/// @desc	returns: the position of the first found char or 0 if nothing was found
function string_find_first( _chars, _string, _start ) {
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
