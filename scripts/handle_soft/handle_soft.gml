/// @func handle_soft
/// @param {int}	exception	the exception to throw
/// @param {array}	attributes	the attributes to pass to the exception when generated
/// @desc	Handles a "soft" exception which will generate an error in the output log but will not
//		crash the program.  These are designed to be used during the catch portion of try/
//		catch block and will _not_ generate catches themselves. They can be used to handle GMS
//		generated exceptions.
/// @example
//handle_soft( FileNotFoundException, "test.txt" );
/// @output An exception in the output log saying test.txt was not found.
/// @wiki Core-Index Exceptions
function handle_soft( _error, _attributes ){
	var _exception	= "exception";
	var _script		= "unknown";
	var _message	= "unknown";
	var _stack		= undefined;
	
	if ( not is_struct( _error ) ) {
		if ( is_numeric( _error ) && script_exists( _error ) ) {
			_exception	= script_get_name( _error );
			_message	= script_execute_ext( _error, ( is_array( _attributes ) ? _attributes : [ _attributes ] ));
			
		} else {
			_message	= _error;
			
		}
		var _stack	= debug_get_callstack();
		var _meta	= string_explode( _stack[ 1 ], ":", false );
		
		_script	= _meta[ 0 ] + "(near line " + _meta[ 1 ] + ")";
		
	} else {
		_message	= _error.message;
		_script		= _error.stacktrace[ 0 ];
		
	}
	syslog( "ERROR! Caught ", _exception, " in ", string( _script ), " :: ", string( _message ) );
	
}
