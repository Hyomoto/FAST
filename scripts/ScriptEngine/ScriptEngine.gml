#macro SCRIPT_ENGINE_MAX_STACK_CALLS	50
/// @func ScriptEngine
/// @param filepath
/// @param *debug?
function ScriptEngine( _filename, _debug ) constructor {
	static manager	= ScriptManager();
	static is_idle	= function() {
		return queue.empty();
		
	}
	static log	= function( _event ) {
		static instance	= ScriptManager().logger;
		
		if ( debug ) {
			var _string	= "[" + _event + "] ";
			
			var _i = 1; repeat( argument_count - 1 ) {
				_string	+= string( argument[ _i++ ] );
				
			}
			instance.write( _string );
			
		}
		
	}
	static load		= function( _filename, _reload ) {
		var _stack	= new DsStack();
		
		static get_file	= function( _path, _file, _reload ) {
			if ( file_exists( _path + _file ) == false ) {
				log( "ScriptEngine.load->get_file", "File \"", _file, "\" does not exist. Skipped!" );
				
				return false;
				
			}
			var _name	= string_copy( _file, 1, string_pos( ".", _file ) - 1 );
			var _last	= scripts[? _name ];
			
			if ( _last != undefined ) {
				if ( _reload != true ) {
					log( "ScriptEngine.load->get_file", "Could not load ", _path, _file," because \"", _name, "\" already exists at ", _last.source, ". Skipped!" );
					
					return false;
					
				}
				_last.discard();
				
			}
			var _script	= new ScriptFile( _path + _file, true );
			
			if ( _script.isFunction ) {
				var _args	= _script.get_line( 0 ).first().get_arguments();
				var _arguments	= array_create( array_length( _args ) )
				
				var _i = 0; repeat( array_length( _arguments ) ) {
					if ( _args[ _i ].size() != 1 || _args[ _i ].first().code != SCRIPT_VARIABLE || _args[ _i ].first().seek ) {
						log( "ScriptEngine.load->get_file", "Could not load ", _path, _file,": malformed function variable \"", string( _args[ _i ] ), ". Skipped!" );
						
						_script.discard();
						
						return false;
						
					}
					_arguments[ _i ]	= _args[ _i ].first().value;
					
					++_i;
					
				}
				return script_add_function( _name, _arguments, _script );
				
			} else {
				scripts[? _name ]	= _script;
				
			}
			return true;
			
		}
		var _file	= filename_name( _filename );
		var _path	= filename_path( _filename );
		var _count	= 0;
		var _found	= 0;
		
		if ( _file != "" ) {
			_count	+= get_file( _path, _file, _reload );
			
			log( "ScriptEngine.load", _filename, " loaded ", ( _count ? "successfully" : "unsuccessfully" ) ,"." );
			
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
					_count += ( get_file( _path, _file, _reload ) ? 1 : 0 );
					_found += 1;
					
				}
				_file	= file_find_next();
				
			}
			file_find_close();
			
		} until ( _stack.empty() );
		
		log( "ScriptEngine.load", _found, " script(s) discovered, ", _count, " script(s) loaded." );
		
	}
	// clears all processing scripts, and discards all stored ones
	static flush	= function() {
		var _key = ds_map_find_first( scripts ); repeat( ds_map_size( scripts ) ) {
			scripts[? _key ].discard();
			
			_key	= ds_map_find_next( scripts, _key );
			
		}
		queue.clear();
		
		ds_map_clear( scripts );
		
		wait	= 0;
		
	}
	// flushes ScriptEngine, and destroys structures
	static discard	= function() {
		flush();
		
		ds_map_destroy( scripts );
		
	}
	static get_value	= function( _key, _undefined ) {
		return values.get( _key, _undefined );
		
	}
	static set_value	= function( _key, _value, _type ) {
		values.set( _key, _value, _type );
		
	}
	static lookup_script	= function( _script ) {
		if ( is_string( _script ) ) {
			var _run	= scripts[? _script ];
			
			if ( _run == undefined ) {
				log( "ScriptEngine.run", "Script \"", _script, "\" not found. Skipped." );
				
				return undefined;
				
			}
			return _run;
			
		}
		return _script;
		
	}
	static enqueue	= function( _script ) {
		_script	= lookup_script( _script );
		
		if ( _script == undefined ) { return; }
		
		log( "ScriptEngine.run", "Queuing script : ", _script.name );
		
		queue.enqueue( _script );
		
	}
	static execute_string	= function( _string ) {
		var _expression	= new ScriptExpression( _string );
		
		log( "ScriptEngine.execute_string", _expression.source );
		
		script_evaluate( _expression, local, self );
		
		local	= {};
		
		syslog( stack );
		
		return stack.pop();
		
	}
	static execute	= function( _script ) {
		var _depth	 = -1;
		var _execute;
		
		_script	= lookup_script( _script );
		
		if ( _script == undefined ) { return; }
		
		log( "ScriptEngine.run", "Executing script : ", _script.name );
		
		_script.last	= _script.startAt;
		
		error	= 0;
		
		while ( _script.eof() == false ) {
			_execute	= _script.read();
			
			if ( _execute.first().code == SCRIPT_LANGUAGE && _execute.first().escape == 2 && _execute.first().level <= _depth ) {
				if ( _execute.first().value == "end" ) {
					continue;
					
				}
				_script.last	= _execute.first().goto;
				
				continue;
				
			}
			switch ( script_evaluate( _execute, _script.local, self ) ) {
				case 2 :
					var _goto	= stack.pop();
					
					if ( stack.pop() == 0 ) {
						_script.last	= _goto;
						
					} else {
						++_depth;
						
					}
					
				case 0 :
					break;
					
				case -1 :
					if ( error == 0 ) { return 0; }
				
					switch ( error ) {
						case 1 :
							log( "ScriptEngine.execute", "Assignment failed on line ", _script.line, " in ", _script.name, ". Aborted!" );
						
							break;
					
					}
					return -1;
				
				default :
					return 0;
				
			}
			
		}
		// clear the stack
		return 0;
		
	}
	static toString	= function() {
		return "ScriptEngine : " + string( ds_map_size( scripts ) ) + " scripts, " + string( queue.size() ) + " in queue.";
		
	}
	scripts	= ds_map_create();
	queue	= new DsQueue();
	values	= new DsNode();
	stack	= new DsStack();
	wait	= 0;
	error	= 0;
	local	= {};
	debug	= ( _debug == true ? true : false );
	event	= new Event( FAST.STEP, 0, undefined, function() {
		if ( wait > 0 ) {
			wait	-= 1;
			
		} else if ( queue.empty() == false ) {
			var _timer	= ( debug ? new Timer( "Took $S seconds", 4 ) : undefined );
			
			while ( queue.empty() == false ) {
				if ( execute( queue.head() ) > 0 ) { break; }
				
				queue.dequeue();
				
			}
			log( "ScriptEngine", _timer );
			
		}
		
	});
	log( "ScriptEngine", "New ScriptEngine created." );
	
	if ( _filename != undefined ) {
		load( _filename );
		
	}
	
}