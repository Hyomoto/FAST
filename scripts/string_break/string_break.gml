/// @func string_break
/// @param {string}	string	The string to break apart
/// @param {int}	width	The number of characters to break at
/// @param {string}	*chars	The character to search for
/// @wiki Core-Index Functions
function string_break( _string, _width, _chars ) {
	if ( string_length( _string ) > _width ) {
		if ( _chars == undefined ) { _chars = " -\n"; }
		
		var _s = 0, _l = 0, _n = 0; while ( _s + _width < string_length( _string ) ) {
			_n	= string_find_first( _chars, _string, _l );
			if ( _n == 0 ) { break; }
			if ( string_char_at( _string, _n ) == "\n" ) {
				_s		= _n;
				
			} else if ( _n > _s + _width ) {
				_string	= string_delete( _string, _l, 1 );
				_string	= string_insert( "\n", _string, _l );
				_s		= _l;
				
			}
			_l	= _n;
			
		}
		
	}
	return _string;
	
}
