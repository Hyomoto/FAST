/// @func FileManager
/// @desc	FileManager is a wrapper for internal file system functions.
/// @wiki Core-Index Files
function FileManager() {
	static manager	= function() constructor {
		static log	= function() {
			static logger	= new Logger( "file", FAST_LOGGER_DEFAULT_LENGTH, System );
			
			var _string	= "";
			
			var _i = 0; repeat( argument_count ) {
				_string	+= string( argument[ _i++ ] );
				
			}
			logger.write( _string );
			
		}
		
	}
	static instance	= new Feature( "FAST File Handling", "1.0", "10/11/2020", new manager() );
	
	return instance.struct;
	
}
FileManager();
