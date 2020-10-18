#macro syslog	( SystemOutput() ).write
#macro System	( SystemOutput() )
/// @func SystemOutput
/// @desc	SystemOutput is a wrapper for the console Output in the GMS IDE. It instantiates itself
//		when called and uses the System and syslog methods as simple references.
/// @wiki Core-Index
function SystemOutput() {
	static instance	= new GenericOutput( function() {
		var _string	= "";
		
		var _i = 0; repeat( argument_count ) {
			_string	+= string( argument[ _i++ ] );
			
		}
		show_debug_message( _string );
		
	});
	return instance;
	
}
