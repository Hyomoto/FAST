/// @func PublisherManager
/// @desc	PublisherManager is a wrapper for internal publisher system functions.
/// @wiki Core-Index Publisher
function PublisherManager(){
	static manager	= function() constructor {
		static log	= function() {
			static logger	= new Logger( "publisher", FAST_LOGGER_DEFAULT_LENGTH, System );
			
			var _string	= "";
			
			var _i = 0; repeat( argument_count ) {
				_string	+= string( argument[ _i++ ] );
				
			}
			logger.write( _string );
			
		}
		
	}
	static instance	= new Feature( "FAST Publisher", "1.1", "07/10/2020", new manager() );
	return instance.struct;
	
}
