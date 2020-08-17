#macro FAST_LOGGER_DEFAULT_LENGTH	144
/// @func ScriptManager
function ScriptManager() {
	static manager	= function() constructor {
		static logger	= new Logger( "ScriptManager", FAST_LOGGER_DEFAULT_LENGTH, System, new FileText( "log/scripts.txt" ) );
		static formatter	= new StringFormatter( "\":save,{:push,}:pull+push,;:strip+push", {
			setup : function( _input ) {
				flag = 0;
				
				if ( string_pos( "//", _input.value ) > 0 ) {
					_input.value	= string_copy( _input.value, 1, string_pos( "//", _input.value ) - 1 );
					
				}
				var _open	= string_pos( "/*", _input.value );
				var _close	= string_pos( "*/", _input.value );
				
				if ( _open > 0 ) {
					if ( _close > 0 ) {
						_input.value	= string_delete( _input.value, _open, _close + 2 - _open );
						
					} else {
						comment	= true;
						_input.value	= string_copy( _input.value, 1, _open - 1 );
						
					}
					
				}
				if ( _open == 0 && _close > 0 ) {
					comment	= false;
					_input.value	= string_delete( _input.value, 1, _close + 1 );
					
				}
				if ( comment ) {
					_input.value	= "";
					
				}
				
			},
			pre : function( _rules ) {
				if ( string_pos( "save", _rules ) > 0 ) {
					flag |= 2;
					
				} else {
					flag ^= flag & 2;
					
				}
				
			},
			strip : function( _input ) {
				if ( flag & 1 && flag & 2 == 0 ) { return; }
				
				_input.value	= string_delete( _input.value, last--, 1 );
				
			},
			skip : function( _input ) {
				if ( flag & 1 && flag & 2 == 0 ) { return; }
				
				last++;
				
			},
			push : function( _input ) {
				if ( flag > 0 && flag & 2 == 0 ) { return; }
				
				_input.value	= string_insert( "\n", _input.value, ++last );
				
			},
			pull : function( _input ) {
				if ( flag > 0 && flag & 2 == 0 ) { return _input; }
				
				_input.value	= string_insert( "\n", _input.value, last++ );
				
			},
			save : function() {
				flag	^= 1;
				
			}
			
		});
		static command	= function( _name, _command ) {
			if ( commands[? _name ] != undefined ) {
				logger.write( "[ScriptManager.command] Command \"" + _name + "\" already exists. Skipped." );
				
			}
			commands[? _name ]	= _command;
			
		}
		commands	= ds_map_create();
		
		commands[? "log" ]	= function( _stack ) {
			syslog( "[SCRIPT] ", "Value ", _stack.pop(), " passed from a script!" );
			
		}
		
	}
	static instance	= new Feature( "FAST Scripts", "1.0", "08/13/2020", new manager() );
	return instance.struct;
	
}
