/// @func ScriptEngine
/// @param filepath
/// @param *debug?
function ScriptEngine( _name, _filepath, _debug ) constructor {
	static execute_string	= function( _expression ) {
		_expression	= new ScriptStatement( _expression );
		
		return _expression.execute( self, {} );
		
	}
	static do_script	= function( _name ) {
		var _script	= scripts[? _name ];
		
		if ( _script == undefined ) {
			log( "ScriptEngine.execute", "Script \"", _name, "\" does not exist. Skipped!" );
			
			return false;
			
		}
		_script.file.reset();
		_script.file.execute( self );
		
	}
	static do_function	= function( _name ) {
		var _func	= funcs[? _name ];
		
		if ( _func == undefined ) {
			log( "ScriptEngine.execute", "Function \"", _name, "\" does not exist. Skipped!" );
			
			return false;
			
		}
		var _args	= {};
		var _arg;
		
		_func.file.reset();
		
		var _i = 1; repeat( array_length( _func.args ) ) {
			_arg	= ( _i < argument_count ? argument[ _i ] : undefined );
			
			variable_struct_set( _args, _func.args[ _i++ - 1 ], _arg );
			
		}
		_func.file.local	= _args;
		_func.file.execute( self );
		
	}
	static load		= function( _filename, _reload ) {
		var _stack	= new DsStack();
		
		static get_file	= function( _path, _filename, _reload ) {
			if ( file_exists( _path + _filename ) == false ) {
				log( "ScriptEngine.load->get_file", "File \"", _file, "\" does not exist. Skipped!" );
				
				return false;
				
			}
			var _name	= string_copy( _filename, 1, string_pos( ".", _filename ) - 1 );
			var _last	= scripts[? _name ];
			var _file	= new FileScript( _path + _filename, true );
			var _line	= _file.get_line( 0 );
			
			if ( is_string( _line ) && string_copy( _line, 1, 9 ) == "function(" ) {
				var _args	= string_explode( string_copy( _line, 10, string_length( _line ) - 11 ), ",", true );
				
				if ( funcs[? _name ] != undefined ) {
					if ( _reload != true ) {
						log( "ScriptEngine.load->get_file", "Could not load function ", _path, _filename," because \"", _name, "\" already exists at ", funcs[? _name ].source, ". Skipped!" );
						
						_file.discard();
						
						return false;
						
					}
					_last.discard();
					
				}
				funcs[? _name ]	= {
					source	: _path + _filename,
					args	: _args,
					file	: _file
				}
				_file.isFunction	= true;
				_file.startAt		= 1;
				
				log( "ScriptEngine.load->get_file", "File ", _path, _filename, " added as function \"", _name, "\"" );
				
				return 2;
				
			} else {
				if ( funcs[? _name ] != undefined ) {
					if ( _reload != true ) {
						log( "ScriptEngine.load->get_file", "Could not load script ", _path, _filename," because \"", _name, "\" already exists at ", scripts[? _name ].source, ". Skipped!" );
						
						_file.discard();
						
						return false;
						
					}
					_last.discard();
					
				}
				scripts[? _name ]	= {
					source	: _path + _filename,
					file	: _file
				}
				log( "ScriptEngine.load->get_file", "File ", _path, _filename, " added as script \"", _name, "\"" );
				
				return 1;
				
			}
			return false;
			
		}
		var _file	= filename_name( _filename );
		var _path	= filename_path( _filename );
		var _scripts= 0;
		var _funcs	= 0;
		var _found	= 0;
		
		if ( _file != "" ) {
			var _result = get_file( _path, _file, _reload );
			
			log( "ScriptEngine.load", _filename, " loaded ", ( _result > 0 ? "successfully" : "unsuccessfully" ) ,"." );
			
			return;
			
		}
		_stack.push( _path );
		
		do {
			_path	= _stack.pop();
			_file	= file_find_first( _path + "*", fa_directory );
			
			while ( _file != "" ) {
				// file_attributes is broken, this is a workaround
				if ( file_exists( _path + _file ) == false ) {
					_stack.push( _path + _file + "/" );
					
				} else {
					switch( get_file( _path, _file, _reload ) ) {
						case 1 : ++_scripts; break;
						case 2 : ++_funcs; break;
					}
					_found += 1;
					
				}
				_file	= file_find_next();
				
			}
			file_find_close();
			
		} until ( _stack.empty() );
		
		log( "ScriptEngine.load", _found, " files(s) discovered, ", _scripts, " script(s) and ", _funcs, " functions loaded." );
		
	}
	static log	= function( _event ) {
		static logger	= ScriptManager().logger;
		static system	= ScriptManager().system;
		
		if ( debug ) {
			var _string	= name + " [" + _event + "] ";
			
			var _i = 1; repeat( argument_count - 1 ) {
				_string	+= string( argument[ _i++ ] );
				
			}
			logger.write( _string );
			system.write( _string );
			
		}
		
	}
	static log_low	= function( _event ) {
		static logger	= ScriptManager().logger;
		
		if ( debug ) {
			var _string	= name + " [" + _event + "] ";
			
			var _i = 1; repeat( argument_count - 1 ) {
				_string	+= string( argument[ _i++ ] );
				
			}
			logger.write( _string );
			
		}
		
	}
	static get_value	= function( _key ) {
		return ds_map_find_value( values, _key );
		
	}
	static set_value	= function( _key, _value ) {
		ds_map_replace( values, _key, _value );
		
	}
	static manager	= ScriptManager();
	
	values	= ds_map_create();
	funcs	= ds_map_create();
	scripts	= ds_map_create();
	debug	= _debug == true;
	name	= _name;
	queue	= new DsQueue();
	run		= new DsWalkable();
	
	ds_map_copy( funcs, ScriptManager().funcs );
	
	if ( _filepath != undefined ) {
		load( _filepath, false );
		
	}
	
}
