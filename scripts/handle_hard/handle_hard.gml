/// @func handle_hard
/// @param {int}	exception	the exception to throw
/// @param {array}	attributes	the attributes to pass to the exception when generated
/// @desc	Handles a "hard" exception which will be presented to the user and follow with the
//		program being terminated.  These are designed to be used during the catch portion of try/
//		catch block and will _not_ generate catches themselves. They can be used to handle GMS
//		generated exceptions.
/// @example
//handle_hard( FileNotFoundException, "test.txt" );
/// @output An error screen saying test.txt was not found, and program terminates.
/// @wiki Core-Index Exceptions
function handle_hard( _error, _attributes ){
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
	var errStr 	= "\n" + _exception + "\n==============================================================="
	var msg		= string( _script ) + " :: " + string( _message )
	
	repeat( string_length( msg ) div ERROR_HANDLER_STRING_LENGTH ) {
		errStr += "\n"+string_copy(msg,1,ERROR_HANDLER_STRING_LENGTH)
        msg = string_copy(msg,101,string_length(msg)-ERROR_HANDLER_STRING_LENGTH)
        if string_length(msg) > 1 {
            if string_char_at(msg,1) != " " {
                if string_char_at(errStr,string_length(errStr)) != " "
                    errStr += "-"
            }
            else msg = string_copy(msg,2,string_length(msg)-1)
        }
		
    }
    errStr += "\n" + msg + "\n===============================================================\n\n"
    
	show_error( errStr, true );
	//throw errStr;
	
}
#macro ERROR_HANDLER_STRING_LENGTH	100
