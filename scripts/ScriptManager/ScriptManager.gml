#macro SCRIPT_EXPRESSION_TYPE_OTHER		0
#macro SCRIPT_EXPRESSION_TYPE_STRING	1
#macro SCRIPT_EXPRESSION_TYPE_NUMBER	2
#macro SCRIPT_EXPRESSION_TYPE_VARIABLE	3
#macro SCRIPT_EXPRESSION_TYPE_OPERAND	4
#macro SCRIPT_EXPRESSION_TYPE_FUNCTION	5

/// @func ScriptManager
function ScriptManager(){
	static manager	= function() constructor {
		static add_cast	= function( _name, _cast, _rebind ) {
			if ( casts[? _name ] != undefined && _rebind != true ) {
				log_notify( undefined, "ScriptManager().add_cast", "Cast \"", _name, "\" already in use. Skipped." );
				
				return;
				
			}
			casts[? _name ]	= _cast;
			
		}
		static add_function	= function( _name, _function, _rebind ) {
			if ( casts[? _name ] != undefined && _rebind != true ) {
				log_notify( undefined, "ScriptManager().add_function", "Function \"", _name, "\" already in use. Skipped." );
				
				return;
				
			}
			funcs[? _name ]	= _function;
			
		}
		formatter	= new StringFormatter( "\":save,\t:replace", {
			setup : function( _input ) {
				flag = 0;
				
				if ( string_pos( "//", _input ) > 0 ) {
					_input	= string_copy( _input, 1, string_pos( "//", _input ) - 1 );
					
				}
				var _open	= string_pos( "/*", _input );
				var _close	= string_pos( "*/", _input );
				
				if ( _open > 0 ) {
					if ( _close > 0 ) {
						_input	= string_delete( _input, _open, _close + 2 - _open );
						
						//return _formatter.format( string_trim( file_text_read_string( _file ) ) ); file_text_readln( _file ); 
						
					} else {
						comment	= true;
						
						_input	= string_copy( _input, 1, _open - 1 );
						
					}
					
				}
				if ( _open == 0 && _close > 0 ) {
					comment	= false;
					
					_input	= string_delete( _input, 1, _close + 1 );
					
				}
				if ( comment ) {
					_input	 = "";
					
				}
				return _input;
				
			},
			pre : function( _rules ) {
				if ( string_pos( "save", _rules ) > 0 ) {
					flag |= 2;
					
				} else {
					flag ^= flag & 2;
					
				}
				
			},
			replace : function( _input ) {
				if ( flag & 1 && flag & 2 == 0 ) { return; }
				
				return string_copy( _input, 1, last - 1 ) + " " + string_delete( _input, 1, last );
				
			},
			save : function( _input ) {
				flag	^= 1;
				
				return _input;
				
			}
			
		});
		var _file	= new FileText( "logs/scripts.txt" );
		
		_file.clear();
		
		parser	= new ScriptParser("");
		system	= new Logger( "Script Manager", FAST_LOGGER_DEFAULT_LENGTH, System );
		logger	= new Logger( "Script Manager", FAST_LOGGER_DEFAULT_LENGTH, _file );
		
		loaded	= ds_list_create();
		casts	= ds_map_create();
		funcs	= ds_map_create();
		
		casts[? "string" ]	= function( _a ) { return string( _a ); }
		casts[? "real" ]	= function( _a ) { return string_to_real( string( _a ) ); }
		
		funcs[? "trace" ]	= function( _value ) { syslog( _value ); };
		
	}
	static instance	= new Feature( "FAST Script", "1.0", "08/22/2020", new manager() );
	return instance.struct;
	
}
