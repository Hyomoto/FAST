/// @func ScriptEngine
/// @param name
/// @param filepath
/// @param *debug?
function ScriptEngine( _name, _filepath, _debug ) constructor {
	static inherit	= function() {
		var _next = ds_map_find_first( ScriptManager().funcs ); repeat( ds_map_size( ScriptManager().funcs ) ) {
			ds_map_add( scripts, _next, method( self, ScriptManager().funcs[? _next ] ) );
			
			_next	= ds_map_find_next( ScriptManager().funcs, _next );
			
		}
		return self;
		
	}
	// converts the given string into a statement that is then executed
	static execute_string	= function( _expression ) {
		return new ScriptStatement( _expression ).execute( self, { script : undefined, statement : undefined, local : {}, last : undefined, depth : -1 } );
		
	}
	// runs a script as part of the engine
	static execute	= function( _name ) {
		var _script	= scripts[? _name ];
		
		if ( _script == undefined ) {
			log( "ScriptEngine.execute", "Script \"", _name, "\" does not exist. Skipped!" );
			
			return false;
			
		}
		var _local	= {};
		
		if( _script.isFunction ) {
			var _i = 1; repeat( argument_count - 1 ) {
				variable_struct_set( _local, _script.args[ _i - 1 ], argument[ _i ] );
				
				++_i;
				
			}
				
		} else {
			var _i = 1; repeat( argument_count - 1 ) {
				stack.push( argument[ _i++ ] );
				
			}
				
		}
		executionStack.push( { script : _script, statement : undefined, local : _local, last : undefined, depth : -1 } );
		
		execution();
		
	}
	static load_async	= function( _filename, _reload, _period ) {
		var _load, _found;
		
		if ( filename_name( _filename ) != "" ) {
			_load	= new DsQueue( _filename );
			
		} else {
			_load	= file_get_directory( _filename );
			
		}
		_found	= _load.size();
		
		if ( _found == 0 ) { return; }
		
		wait	= ScriptManager().WaitCondition( self, undefined );
		wait.load	= _load;
		//wait.reload	= _reload;
		wait.period	= _period;
		wait.funcs	= 0;
		wait.scripts	= 0;
		wait.total	= _load.size();
		wait.update	= method( wait, function() {
			var _time	= get_timer();
			
			do {
				var _script	= script_file_load( load.dequeue() );
				
				_script.validate( engine, true );
				
				engine.scripts[? _script.name ]= _script;
				++scripts;
				
			} until ( load.empty() || get_timer() - _time > period );
			
			if ( load.empty() == true ) {
				engine.log( "ScriptEngine.load", total, " files(s) discovered, ", scripts, " loaded." );
				engine.wait	= undefined;
				
			}
			
		});
		
	}
	static load		= function( _filename, _reload ) {
		var _scripts	= 0;
		var _load, _found;
		
		if ( filename_name( _filename ) != "" ) {
			_load	= new DsQueue( _filename );
			
		} else {
			_load	= file_get_directory( _filename );
			
		}
		_found	= _load.size();
		
		while ( _load.empty() == false ) {
			var _script	= script_file_load( _load.dequeue() );
			
			_script.validate( self, true );
			
			scripts[? _script.name ]= _script;
			++_scripts;
			
		}
		log( "ScriptEngine.load", _found, " files(s) discovered, ", _scripts, " loaded." );
		
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
	static get_value	= function( _key ) {
		return ds_map_find_value( values, _key );
		
	}
	static set_value	= function( _key, _value ) {
		ds_map_replace( values, _key, _value );
		
	}
	static get_queue	= function() {
		return parseQueue;
		
	}
	static set_queue	= function( _queue ) {
		parseQueue	= _queue;
		
	}
	static proceed	= function() {
		wait	= undefined;
		
	}
	static is_running	= function() {
		return queue.empty() == false || executionStack.empty() == false;
		
	}
	static is_waiting	= function() {
		return wait != undefined;
		
	}
	static is		= function( _data_type ) {
		return _data_type == ScriptEngine;
		
	}
	static toString	= function() {
		return "ScriptEngine(" + name + ") : Scripts in queue(" + string( queue.size() + executionStack.size() ) + ") : Run(" + ( is_running() ? "true" : "false" ) + ") : Wait(" + ( is_waiting() ? "true" : "false" ) + ")";
		
	}
	static manager	= ScriptManager();
	
	//parser	= new Parser();
	//toParse	= new DsQueue();
	executionStack	= new DsStack();
	executionStop	= false;
	
	parseQueue		= new DsQueue();
	
	values	= ds_map_create();
	funcs	= ds_map_create();
	scripts	= ds_map_create();
	errors	= new DsStack();
	queue	= new DsQueue();
	stack	= new DsStack();
	wait	= undefined;
	debug	= _debug == true;
	name	= _name;
	
	execution	= ( debug ? function() {
		try {
			executionStack.top().script.execute( self );
			
		} catch( _ex ) {
			log( "execute", _ex );
			
			executionStack.clear();
			queue.clear();
			stack.clear();
			
		}
		
	}
	: function() {
		executionStack.top().script.execute( self );
		
	});
	
	event	= new Event( FAST.STEP, 0, undefined, function() {
		executionStop	= false;
		
		if ( wait != undefined ) {
			try {
				wait.update();
				
			} catch( _ex ) {
				log( "execute", _ex );
				
				wait	= undefined;
				
				executionStack.clear();
				queue.clear();
				stack.clear();
				
				return;
				
			}
			
		}
		while ( wait == undefined && ( queue.empty() == false || executionStack.empty() == false ) ) {
			if ( executionStack.empty() ) {
				executionStack.push( { script : queue.dequeue(), statement : undefined, local : {}, last : undefined, depth : -1 } );
				
			}
			execution();
			
			if ( executionStop ) { break; }
			
		}
		
	});
	if ( _filepath != undefined ) {
		load( _filepath, false );
		
	}
	
}
