#macro syslog	( system_log() ).write
#macro System	( system_log() )
/// @func system_log
/// @desc	system_log is a wrapper for the console Output in the GMS IDE. It instantiates itself
//		when called and uses the System and syslog methods as simple references.
/// @wiki Core-Index
function system_log() {
	static instance	= new __GenericOutput__( function() {
		var _string	= "";
		
		var _i = 0; repeat( argument_count ) {
			_string	+= string( argument[ _i++ ] );
			
		}
		show_debug_message( _string );
		
	});
	return instance;
	
}
