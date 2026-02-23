/// @param {string} _from	A location to load from.
/// @param {struct} _to		A struct to write things to.
/// @desc
function parse_things( _from, _to ) {
	var _files = file_search( _from );
	var _open	= [];
	var _closed	= [];
	var _hits	= 0;
	
	while( array_length( _files ) > 0 || array_length( _open ) > 0 ) {
		var _file, _read, _s;
		if ( array_length( _files ) > 0 ) {
			_file	= array_pop( _files );
			_read	= file_text_read( _file );
			_s	= 1;
			
		} else {
			_file	= array_last( _open )[ 0 ];
			_read	= array_last( _open )[ 1 ];
			_s		= array_last( _open )[ 2 ];
			array_pop( _open );
			
		}
		var _i		= _s - 1;
		
		while( _i < string_length( _read )) { ++_i;
			if ( string_char_at( _read, _i ) == "\"" || string_char_at( _read, _i ) == "'" ) {
				var _close	= string_char_at( _read, _i++ );
				while( string_char_at( _read, _i ) != _close ) { ++_i; }
				
			} else if ( _i == string_length( _read ) || ( string_char_at( _read, _i ) == "-" && string_char_at( _read, _i + 1 ) == "-" )) {
				var _break	= false;
				
				try {
					var _thing	= parse_thing( string_copy( _read, _s, _i - _s ), _to );
					_to[$ _thing.uid ]	= _thing;
					_hits	+= 1;
					
				} catch ( _ex ) {
					if ( string_pos( "Extend declaration not found:", _ex.message ) == 0
					&& string_pos( "From declaration not found:", _ex.message ) == 0
					&& string_pos( "Import declaration not found:", _ex.message ) == 0 ) {
						_ex.message += $" in {_file}";
						throw _ex;
						
					}
					array_insert( _closed, 0, [ _file, _read, _s ] );
					_break	= true;
					
				}
				if ( _break || _i > string_length( _read ))
					break;
				
				_s	= _i + 2;
				_i	= _s - 1;
				
			}
			
		}
		if ( array_length( _open ) == 0 && array_length( _closed ) > 0 ) {
			if ( _hits == 0 ) {
				var _fail	= "Parse Things - Unresolvable definitions found:\n";
				var _e = 0; repeat( array_length( _closed )) {
					_fail += _closed[ _e++ ][ 0 ] + " ";
					
				}
				throw new Exception( _fail );
				
			} else {
				_open	= _closed;
				_closed	= [];
				
			}
			_hits	= 0;
			
		}
		
	}
	return _to;
	
}
