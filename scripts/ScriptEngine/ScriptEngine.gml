/// @func ScriptEngine
/// @desc	The script engine can be used to execute scripts and handle coroutines.  While scripts
///		can be executed manually, the script engine will handle the more complex yield states of
///		scripts by calling update().  When a script is executed, if it returns a yield it will be
///		placed into a queue that will be executed each frame until it resolves.
/// @example
//engine	= new ScriptEngine();
//engine.load_async("txt", "", false )
/// @output Loads all .txt files in the included files as scripts.
function ScriptEngine() : __Struct__() constructor {
	/// @param {mixed}	source		A script or string to execute
	/// @param {mixed}	*args...	Arguments to pass into the script
	/// @desc	Calls for a script or function to be executed and returns the result.  If the
	///		source is a {#Script} and calls a yield, it will be executed each frame until it
	///		resolves.  If the source can not be resolved into a script or function
	///		InvalidArgumentType will be thrown.
	/// @throws InvalidArgumentType
	/// @returns mixed
	static execute	= function( _script ) {
		var _args	= array_create( argument_count - 1 );
		var _f		= is_string( _script ) ? __Variables__[$ _script ] : _script;
		var _output;
		
		var _i = 0; repeat( array_length( _args )) { ++_i;
			_args[ _i - 1 ]	= argument[ _i ];
			
		}
		if ( _f == undefined || struct_type( _f, Script ) == false )
			throw new InvalidArgumentType( "ScriptEngine.execute", 0, _script, "Script" );
		
		var _h	= __fast_script_trace__( __Output ); // set this engine as the script scope
		try {
			if ( __Global__ != undefined )
				_f.use_global( __Global__ );
			switch ( array_length( _args ) ) {
				case 0 : _output = _f.execute(); break;
				case 1 : _output = _f.execute( _args[ 0 ] ); break;
				case 2 : _output = _f.execute( _args[ 0 ], _args[ 1 ] ); break;
				case 3 : _output = _f.execute( _args[ 0 ], _args[ 1 ], _args[ 2 ] ); break;
				case 4 : _output = _f.execute( _args[ 0 ], _args[ 1 ], _args[ 2 ], _args[ 3 ] ); break;
				case 5 : _output = _f.execute( _args[ 0 ], _args[ 1 ], _args[ 2 ], _args[ 3 ], _args[ 4 ] ); break;
			}
			if ( _f.__Lump.state == FAST_SCRIPT_YIELD )
				__Coroutines__.push( new ScriptCoroutine( _f, _f.__Lump ));
			
		} catch ( _ex ) {
			trace( "ScriptEngine error::\n" + _ex.message );
			
		}
		__fast_script_trace__( _h ); // unset engine scope
		
		return _output;
		
	}
	/// @desc	Used to route calls to the output in this engine, allowing routing of trace
	///		calls from within scripts.
	static trace	= function( _string ) {
		__Output.write( _string );
		
	}
	/// @desc	Calls for the engine to execute any scripts that have yielded.
	static update	= function() {
		var _h	= __fast_script_trace__( __Output ); // set this engine as the script scope
		try {
			repeat( __Coroutines__.size() ) {
				var _co	= __Coroutines__.pop(0);
				
				_co.execute();
				
				if ( _co.is_yielded() )
					__Coroutines__.push( _co );
				
			}
		} catch ( _ex ) {
			trace( "ScriptEngine error::\n" + _ex.message );
			
		}
		__fast_script_trace__( _h ); // unset engine scope
		
	}
	/// @param {bool}	allow	If false, will not allow global access
	/// @desc	If allow is not false, the engine global scope will be reachable from executed
	///		scripts.  By disallowing this, only the script's local function scope can be used.
	static allow_global	= function( _allow ) {
		if ( _allow == false ) { __Global__ = undefined; }
		__Global__ = __Variables__;
		
		return self;
		
	}
	/// @param {struct}	struct	A struct to use for global space
	/// @desc	Allows you to define the global space that is passed into scripts when they are
	///		executed.  This space is persistent unless overwritten.
	static set_global	= function( _struct ) {
		__Global__ = _struct;
		
		return self;
		
	}
	/// @param {__OutputStream__}	output	An output stream
	/// @desc	By default ScriptEngine will write trace calls and errors to {$SystemOutput}, but you
	///		can override this behavior by providing an output stream.
	static set_output	= function( _struct ) {
		if ( struct_type( _struct, __OutputStream__ ) == false )
			throw new InvalidArgumentType( "set_output", 0, _struct, "__OutputStream__" );
		__Output	= _struct;
		
		return self;
		
	}
	/// @param {string}	name	The name to assign the function to
	/// @param {method}	value	The function to assign
	/// @desc	Binds the given value to name.  This value will be accessible to scripts that are
	///		executed from the engine.  You can bind values, functions, methods and Scripts.
	static bind	= function( _name, _value ) {
		if ( is_method( _value ) || struct_type( _value, Script ))
			__Variables__[$ _name ]	= _value;
		else
			__Variables__[$ _name ]	= method( undefined, _value );
		
	}
	/// @param {__InputStream__}	source	A input stream
	/// @desc	Loads the given stream of files.  Execution is yielded if the load process takes too
	///		long. Returns a method that, when called, will return if load_async has completed.  If
	///		source is not an {#__InputStream__}, InvalidArgumentType is thrown.  If a file is not
	///		found, FileNotFound will be thrown.
	/// @throws InvalidArgumentType, FileNotFound
	/// @returns method
	static load_async	= function( _source, _on_finish ) {
		if ( struct_type( _source, __Stream__ ))
			_source	= new __Stream__( _source ).open();
		
		if ( __Async__ != undefined ) { return; }
		
		static __load__	= new Script().from_string(
			"temp time_, list_\n" +
			"while list_.finished() == False\n" +
			" temp f as list_.read()\n" +
			"// trace f\n" +
			" load f\n" +
			" if time_.elapsed() > 250000\n" +
			"  time_.reset()\n" +
			"  yield"
		)//.timeout(infinity);
		
		if ( struct_type( _source, __InputStream__ ) == false )
			throw new InvalidArgumentType( "ScriptEngine.load", 0, _source, "__InputStream__" );
		
		var _output	= __load__.execute( new Timer(), _source );
		
		if ( __load__.__Lump.state == FAST_SCRIPT_YIELD ) {
			__Async__ = new FrameEvent( FAST.STEP, 0, function( _p ) {
				try {
					_p.c.execute();
					
					if ( not _p.c.is_yielded() ) {
						trace( "ScriptEngine load_async complete." );
						__Async__.discard();
						__Async__ = undefined;
						
						if ( _p.f != undefined )
							_p.f();
						
					}
					
				} catch ( _ex ) {
					trace( "ScriptEngine load_async error::\n" + _ex.message );
					
				}
				
			}).parameter({c: new ScriptCoroutine( __load__, __load__.__Lump ), f: _on_finish });
			
		}
		// should return a function that can be used to measure progress, for now just returns if async completed
		return function() {
			if ( __Async__ == undefined ) { return true; }
			return false;
			
		}
		
	}
	/// @param {string}	filename	The name of the file
	/// @param {string} *as			optional: The name to load the file as
	/// @desc	Loads the given filename as a script.  If as is not provided, the script will be
	///		loaded using the name of the file.  If filename or as is not a string, InvalidArgumentType
	///		will be thrown.  If the file does not exist, FileNotFound will be thrown.
	/// @throws InvalidArgumentType, FileNotFound
	static load		= function( _filename, _as ) {
		// error handling
		if ( is_string( _filename ) == false ) { throw new InvalidArgumentType( "load", 0, _filename, "string" ); }
		if ( file_exists( _filename ) == false ) { throw new FileNotFound( "load", _filename ); }
		if ( _as == undefined ) {
			var _name	= filename_name( _filename );
			var _dot	= string_pos( ".", _name );
			
			_as	= _dot == 0 ? _name : string_copy( _name, 1, _dot - 1 );
			
		}
		// get script name
		if ( is_string( _as ) == false ) { throw new InvalidArgumentType( "load", 1, _as, "string" ); }
		
		__Variables__[$ _as ]	= new Script().from_input( new TextFile().open( _filename ));
		
		return self;
		
	}
	__Output		= SystemOutput;
	
	__Coroutines__	= new LinkedList();
	__Variables__	= {};
	__Global__		= undefined;
	__Async__		= undefined;
	
	__Type__.add( ScriptEngine );
	
}
