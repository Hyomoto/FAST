/// @func InputManager
/// @desc	InputManager is a wrapper for internal file system functions.
/// @wiki Input-Handling-Index
function InputManager() {
	static manager	= function() constructor {
		static log	= function() {
			if ( FAST_DEBUGGER_ENABLE == false ) { return; }
			
			static logger	= new Logger( "input", FAST_LOGGER_DEFAULT_LENGTH, System );
			
			var _string	= "";
			
			var _i = 0; repeat( argument_count ) {
				_string	+= string( argument[ _i++ ] );
				
			}
			logger.write( _string );
			
		}
		
	}
	static instance	= new Feature( "FAST Input Handling", "1.0a", "10/18/2020", new manager() );
	return instance.struct;
	
}
InputManager();
