syslog( "FAST is shutting down..." );

__Fast__.call_events( __Fast__.GAME_END );

syslog( "Complete." );
