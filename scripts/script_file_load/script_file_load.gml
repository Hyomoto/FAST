/// @func script_file_load
/// @param filename
function script_file_load( _filename ) {
	var _formatter	= ScriptManager().formatter;
	var _file		= file_text_open_read( _filename );
	var _script		= new Script();
	var _last		= 0;
	var _file_line	= 0;
	var _goto		= new DsStack();
	var	_logic		= 0;
	var _name, _line;
	
	_formatter.comment	= false;
	
	while ( file_text_eof( _file ) == false ) {
		// get next line
		_line	= _formatter.format( string_trim( file_text_read_string( _file ) ) ); file_text_readln( _file );
		_name	= filename_name( _filename );
		_name	= ( string_pos( ".", _name ) > 0 ? string_copy( _name, 1, string_pos( ".", _name ) - 1 ) : _name );
		++_file_line;
		
		_script.source	= _filename;
		_script.name	= _name;
		
		if ( _last++ == 0 ) {
			if ( string_copy( _line, 1, 9 ) == "function(" ) {
				_script.args	= string_explode( string_copy( _line, 10, string_length( _line ) - 11 ), ",", true );
				_logic			= 3;
				
				_script.isFunction	= true;
				
				continue;
				
			}
			
		}
		if ( string_pos( "<<", _line ) == 1 ) {
			_line	= string_delete( _line, 1, 2 ) + "";
			_logic	= 1;
			
		}
		if ( string_pos( ">>", _line ) > 0 ) {
			_line	= string_copy( _line, 1, string_pos( ">>", _line ) - 1 ) + "";
			_logic	= 2;
			
		}
		if ( _line != "" ) {
			if ( _logic ) {
				_script.add( new ScriptStatement( _line ) );
				
				if ( _script.final.value.close ) {
					if ( _goto.empty() == false ) {
						var _pop	= _goto.pop();
						
						_pop.value.goto = _script.final;
						
						if ( _script.final.value.keyword == "loop" ) {
							_script.final.value.depth	= _goto.size() - 1;
							
							_script.final.value.goto = _pop;
							
						}
						
					}
					
				}
				if ( _script.final.value.open ) {
					_script.final.value.depth	= _goto.size();
					
					_goto.push( _script.final );
					
				}
				_script.final.value.line	= _file_line;
				
			} else {
				_script.add( _line );
				
			}
			
		}
		if ( _logic == 2 ) {
			_logic	= 0;
			
		}
		
	}
	file_text_close( _file );
	
	_script.validate( self, true );
	
	return _script;
	
}