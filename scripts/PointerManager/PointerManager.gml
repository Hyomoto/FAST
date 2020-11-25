/// @desc PointerManager
function PointerManager() {
	static manager	= function() constructor {
		static log	= function() {
			if ( FAST_DEBUGGER_ENABLE == false ) { return; }
			
			static logger	= new Logger( "pointer", FAST_LOGGER_DEFAULT_LENGTH, System );
			
			var _string	= "";
			
			var _i = 0; repeat( argument_count ) {
				_string	+= string( argument[ _i++ ] );
				
			}
			logger.write( _string );
			
		}
		
	}
	static instance	= new Feature( "FAST Pointer", "1.0.0", "10/23/2020", new manager() );
	return instance.struct;
	
}
