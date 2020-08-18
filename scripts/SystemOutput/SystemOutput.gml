#macro syslog	( SystemOutput() ).write
#macro System	( SystemOutput() )

function SystemOutput() {
	static instance	= new Output( function() {
		var _string	= "";
		
		var _i = 0; repeat( argument_count ) {
			_string	+= string( argument[ _i++ ] );
			
		}
		show_debug_message( _string );
		
	});
	return instance;
	
}
