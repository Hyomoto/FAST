/// @func string_break
function string_break( _string, _width, _chars ) {
	if ( string_length( _string ) > _width ) {
		if ( _chars == undefined ) { _chars = " "; }
		
		var _l = 0, _n = 0; while ( true ) {
			_n	= string_find_first( _chars, _string, _l );
			
			if ( _n == 0 ) { break; }
			if ( _n > _width ) {
				_string	= string_delete( _string, _l, 1 );
				_string	= string_insert( "\n", _string, _l );
				
				if ( string_length( _string ) - _n <= _width )
					break;
				
			}
			_l	= _n;
			
		}
		
	}
	return _string;
	
}
