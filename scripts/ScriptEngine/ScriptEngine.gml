/// @func ScriptEngine
/// @param filepath
/// @param *debug?
function ScriptEngine( _name, _filepath, _debug ) constructor {
	// converts the given string into a statement that is then executed
	static execute_string	= function( _expression ) {
		return new ScriptStatement( _expression ).execute( self, {} );
		
	}
	static execute	= function( _package ) {
		var _script	= _package.script;
		var _reread	= false;
		var _ex, _last;
		var _count	= 0;
		
		while ( _script.has_next( _package.last ) ) {
			if ( _reread == false ) {
				_package.last	= _script.next( _package.last );
				
			}
			_last			= _package.last;
			_ex				= _last.value;
			_reread			= false;
			++lines;
			
			if ( is_string( _ex ) ) {
				parse( _ex );
				
				continue;
				
			}
			if( _ex.ignore ) { continue; }
			if ( _ex.ends ) {
				if ( _package.script.args == undefined && _ex.keyword == "wait" ) {
					if ( _script.has_next( _last ) ) {
						var _time	= _ex.execute( self, _package );
						
						if ( _time != undefined ) {
							wait	= new EventOnce( FAST.STEP, _time, _package, function( _package ) {
								execute( _package );
							
							});
							
						} else {
							queue.enqueue_at_head( _package );
							
							wait	= true;
							
						}
						
					}
					return;
					
				}
				return _ex.execute( self, _package );
				
			}
			if ( _ex.close ) {
				if ( _ex.keyword == "loop" ) {
					_package.depth -= 1;
					
					if ( _package.depth < _ex.depth ) { continue; }
					
					_package.last	= _ex.goto;
					_reread			= true;
					
				} else if ( _ex.keyword == "end" ) {
					_package.depth -= 1;
					
					continue;
					
				}
				
			}
			if ( _ex.open ) {
				if ( _package.depth < _ex.depth && _ex.execute( self, _package ) ) {
					_package.depth	+= 1;
					
					continue;
					
				}
				_package.last	= _ex.goto;
				_reread			= true;
				
			} else {
				_ex.execute( self, _package );
				
			}
			
		}
		return undefined;
		
	}
	// runs a script as part of the engine
	static run_script	= function( _name ) {
		var _seek	= scripts[? _name ];
		var _result;
		
		if ( _seek == undefined ) {
			log( "ScriptEngine.execute", "Script \"", _name, "\" does not exist. Skipped!" );
			
			return false;
			
		}
		execute( { script : _seek, local : {}, last : undefined, depth : -1 } );
		
	}
	static run_function	= function( _name ) {
		var _seek	= funcs[? _name ];
		
		if ( _seek == undefined ) {
			log( "ScriptEngine.execute", "Function \"", _name, "\" does not exist. Skipped!" );
			
			return false;
			
		}
		var _args	= {};
		var _arg;
		
		var _i = 1; repeat( array_length( _seek.args ) ) {
			_arg	= ( _i < argument_count ? argument[ _i ] : undefined );
			
			variable_struct_set( _args, _seek.args[ _i++ - 1 ], _arg );
			
		}
		execute( { script : _seek, local : _args, last : undefined, depth : -1 } );
		
	}
	static file_load	= function( _filename, _reload, _formatter ) {
		var _file		= file_text_open_read( _filename );
		var _script		= new Script();
		var _last		= 0;
		var _file_line	= 0;
		var _goto		= new DsStack();
		var	_logic		= 0;
		var _type		= 0;
		var _name, _line;
		
		_formatter.comment	= false;
		
		while ( file_text_eof( _file ) == false ) {
			// get next line
			_line	= _formatter.format( string_trim( file_text_read_string( _file ) ) ); file_text_readln( _file );
			_name	= filename_name( _filename );
			_name	= ( string_pos( ".", _name ) > 0 ? string_copy( _name, 1, string_pos( ".", _name ) - 1 ) : _name );
			++_file_line;
			
			_script.source	= _filename;
			
			if ( _last++ == 0 ) {
				if ( string_copy( _line, 1, 9 ) == "function(" ) {
					_script.args	= string_explode( string_copy( _line, 10, string_length( _line ) - 11 ), ",", true );
					_logic			= 3;
					
					funcs[? _name ]	= _script;
					
					_type	= 1;
					
					continue;
					
				} else {
					scripts[? _name ]	= _script;
					
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
		
		return _type;
		
	}
	static load_async	= function( _filename, _reload, _period ) {
		var _formatter	= ScriptManager().formatter;
		var _load, _found;
		
		if ( filename_name( _filename ) != "" ) {
			_load	= new DsStack( _filename );
			
		} else {
			_load	= file_get_directory( _filename );
			
		}
		_found	= _load.size();
		
		if ( _found == 0 ) { return; }
		
		wait	= new Event( FAST.STEP, 0, { load : _load, reload : _reload, format : _formatter, period : _period, funcs: 0, scripts : 0, total : _load.size() }, function( _package ) {
			var _time	= get_timer();
			
			do {
				switch ( file_load( _package.load.dequeue(), _package.reload, _package.format ) ) {
					case 1 : _package.funcs += 1; break;
					default: _package.scripts+=1; break;
					
				}
				
			} until ( _package.load.empty() || get_timer() - _time > _package.period );
			
			if ( _package.load.empty() == true ) {
				log( "ScriptEngine.load", _package.total, " files(s) discovered, ", _package.scripts, " script(s) and ", _package.funcs, " functions loaded." );
				
				wait.discard();
				
				wait	= undefined;
				
			}
			
		});
		
	}
	static load		= function( _filename, _reload ) {
		var _formatter	= ScriptManager().formatter;
		var _scripts	= 0;
		var _funcs		= 0;
		var _load, _found;
		
		if ( filename_name( _filename ) != "" ) {
			_load	= new DsStack( _filename );
			
		} else {
			_load	= file_get_directory( _filename );
			
		}
		_found	= _load.size();
		
		while ( _load.empty() == false ) {
			switch ( file_load( _load.pop(), _reload, _formatter ) ) {
				case 1 : ++_funcs; break;
				default: ++_scripts; break;
				
			}
			
		}
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
	static proceed	= function() {
		if ( wait == true ) { wait = undefined; }
		
		execute( queue.dequeue() );
		
	}
	static enqueue	= function( _source ) {
		var _target	= ( is_string( _source ) ? scripts[? _source ] : _source );
		
		if ( _target == undefined || instanceof( _target ) != "Script" ) {
			log( "enqueue", "Script ", _source, " was not a valid script. Ignored!" );
			
			return;
			
		}
		queue.enqueue( _target );
		
	}
	static parse		= function( _string ) {
		if ( parser.has_next() == false ) {
			parser.parse( _string );
			
		} else {
			toParse.enqueue( _string );
			
		}
		
	}
	static has_next	= function() {
		return toParse.empty() == false;
		
	}
	static next		= function() {
		if ( has_next() ) {
			parser.parse( toParse.dequeue() );
			
		}
		
	}
	static push		= function() {
		var _i = 0; repeat( argument_count ) {
			stack.push( argument[ _i++ ] );
			
		}
		
	}
	static pop		= function() {
		return stack.pop();
		
	}
	static is_running	= function() {
		return queue.size() > 0;
		
	}
	static is_waiting	= function() {
		return wait != undefined;
		
	}
	static is		= function( _data_type ) {
		return _data_type == ScriptEngine;
		
	}
	static toString	= function() {
		return "ScriptEngine(" + name + ") : Scripts in queue(" + string( queue.size() ) + ") : Wait(" + ( wait == undefined ? "false" : "true" ) + ")";
		
	}
	static manager	= ScriptManager();
	
	event	= new Event( FAST.STEP, 0, undefined, function() {
		while ( wait == undefined && queue.empty() == false ) {
			execute( { script : queue.dequeue(), local : {}, last : undefined, depth : -1 } );
			
		}
		
	});
	parser	= new Parser();
	toParse	= new DsQueue();
	values	= ds_map_create();
	funcs	= ds_map_create();
	scripts	= ds_map_create();
	errors	= new DsStack();
	queue	= new DsQueue();
	stack	= new DsStack();
	wait	= undefined;
	debug	= _debug == true;
	name	= _name;
	lines	= 0;
	loading	= 0;
	
	var _next = ds_map_find_first( ScriptManager().funcs ); repeat( ds_map_size( ScriptManager().funcs ) ) {
		ds_map_add( funcs, _next, method( self, ScriptManager().funcs[? _next ] ) );
		
		_next	= ds_map_find_next( ScriptManager().funcs, _next );
		
	}
	if ( _filepath != undefined ) {
		load( _filepath, false );
		
	}
	
}
