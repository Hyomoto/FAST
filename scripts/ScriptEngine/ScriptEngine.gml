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
		if ( _f == undefined )
			throw new InvalidArgumentType( "ScriptEngine.execute", 0, _script, "Script" );
		
		try {
			if ( struct_type( _f, Script )) {
				switch ( array_length( _args ) ) {
					case 0 : _output = _f.execute( __Global__, undefined ); break;
					case 1 : _output = _f.execute( __Global__, undefined, _args[ 0 ] ); break;
					case 2 : _output = _f.execute( __Global__, undefined, _args[ 0 ], _args[ 1 ] ); break;
					case 3 : _output = _f.execute( __Global__, undefined, _args[ 0 ], _args[ 1 ], _args[ 2 ] ); break;
					case 4 : _output = _f.execute( __Global__, undefined, _args[ 0 ], _args[ 1 ], _args[ 2 ], _args[ 3 ] ); break;
					case 5 : _output = _f.execute( __Global__, undefined, _args[ 0 ], _args[ 1 ], _args[ 2 ], _args[ 3 ], _args[ 4 ] ); break;
				}
				if ( _output.state == FAST_SCRIPT_YIELD )
					__Coroutines__.push( new ScriptCoroutine( _f, _output ));
				return _output.result;
			
			}
			switch ( array_length( _args ) ) {
				case 0 : return _f();
				case 1 : return _f( _args[ 0 ] );
				case 2 : return _f( _args[ 0 ], _args[ 1 ] );
				case 3 : return _f( _args[ 0 ], _args[ 1 ], _args[ 2 ] );
				case 4 : return _f( _args[ 0 ], _args[ 1 ], _args[ 2 ], _args[ 3 ] );
				case 5 : return _f( _args[ 0 ], _args[ 1 ], _args[ 2 ], _args[ 3 ], _args[ 4 ] );
			}
			
		} catch ( _ex ) {
			show_debug_message( "ScriptEngine error::\n" + _ex.message );
			
		}
		
	}
	/// @desc	Calls for the engine to execute any scripts that have yielded.
	static update	= function() {
		try {
			repeat( __Coroutines__.size() ) {
				var _co	= __Coroutines__.pop(0);
			
				_co.execute( __Variables__ );
			
				if ( _co.is_yielded() )
					__Coroutines__.push( _co );
			
			}
		} catch ( _ex ) {
			show_debug_message( "ScriptEngine error::\n" + _ex.message );
			
		}
		
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
		if ( _allow == false ) { __Global__ = undefined; }
		__Global__ = __Variables__;
		
		return self;
		
	}
	/// @param {string}	name	The name to assign the function to
	/// @param {method}	value	The function to assign
	/// @desc	Binds the given value to name.  This value will be accessible to scripts that are
	///		executed from the engine.  You can bind values, functions, methods and Scripts.
	static bind	= function( _name, _value ) {
		__Variables__[$ _name ]	= _value;
		
	}
	/// @param {string}	name	The name to assign the function to
	/// @param {method}	value	The function to assign
	/// @desc	Used to bind script functions to the engine when FAST_SCRIPT_PROTECT_FUNCTIONS is
	///		true.  Because of how GMS looks up functions internally, a user could reach unintended
	///		functions in GMS by simply executing numbers as functions.  This will wrap the function
	///		that reference in ScriptFunctionWrapper which flags this value as acceptable for function calls.
	static bind_safe	= function( _name, _value ) {
		__Variables__[$ _name ]	= new ScriptFunctionWrapper( _value );
		
	}
	/// @param {__InputStream__}	source	A input stream
	/// @desc	Loads the given stream of files.  Execution is yielded if the load process takes
	///		too long.  If source is not an {#__InputStream__}, InvalidArgumentType is thrown.
	/// @throws InvalidArgumentType, FileNotFound
	static load_async	= function( _source ) {
		if ( __Async__ != undefined ) { return; }
		
		static __load__	= new Script().from_input( new Queue().write(
			"func time_, list_, print_",
			"while list_.finished:: == False",
			" load list_.read::",
			" if time_.elapsed:: > 250000",
			"  yield",
			"  time_.reset::"
		)).timeout(infinity);
		
		if ( struct_type( _source, __InputStream__ ) == false ) { throw new InvalidArgumentType( "ScriptEngine.load", 0, _source, "__InputStream__" ); }
		
		var _output	= __load__.execute( __Variables__, undefined, new Timer(), _source, new ScriptFunctionWrapper( show_debug_message ));
		
		if ( _output.state == FAST_SCRIPT_YIELD ) {
			__Async__ = new FrameEvent( FAST.STEP, 0, function( _p ) {
				try {
					_p.execute( __Variables__ );
					
					if ( not _p.is_yielded() ) {
						show_debug_message( "ScriptEngine load_async complete." );
						__Async__.discard();
						__Async__ = undefined;
						
					}
					
				} catch ( _ex ) {
					show_debug_message( "ScriptEngine load_async error::\n" + _ex.message );
					
				}
				
			}).parameter( new ScriptCoroutine( __load__, _output ));
			
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
	__Coroutines__	= new LinkedList();
	__Variables__	= {};
	__Global__		= undefined;
	__Async__		= undefined;
	
	__Type__.add( ScriptEngine );
	
}
