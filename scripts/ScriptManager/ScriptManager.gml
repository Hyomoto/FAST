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
		static is_reserved	=function( _keyword ) {
			return reserved.contains( _keyword );
			
		}
		formatter	= new StringFormatter( "\":save,\t:replace", {
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
			replace : function( _input ) {
				if ( flag & 1 && flag & 2 == 0 ) { return; }
				
				_input.value	= string_copy( _input.value, 1, last - 1 ) + " " + string_delete( _input.value, 1, last );
				
			},
			save : function() {
				flag	^= 1;
				
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
		funcs[? "errors" ]	= function() { return errors.size(); }
		funcs[? "error" ]	= function( _index ) { return errors.pop(); }
		funcs[? "error_clear" ]	= function() { errors.clear() }
		funcs[? "throw" ]	= function( _source, _error ) { errors.push( [ _source, _error ] ); }
		funcs[? "array" ]	= function( _array, _index ) { syslog( _index ); return _array[ _index ]; }
		
		reserved= new Array([
			"var", "if", "else", "elseif", "end", "wait", "return", "loop", "queue", "push", "pop", "set"
		]);
	}
	static instance	= new Feature( "FAST Script", "1.0", "08/22/2020", new manager() );
	return instance.struct;
	
}
