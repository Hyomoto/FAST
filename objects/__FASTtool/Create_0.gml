__Fast__	= FAST;

if ( __Fast__.start ) {
	syslog( "Duplicate __Fast__ Manager created, destroying." );
	
	instance_destroy();
	
	exit;
	
}
syslog( __Fast__.toString( true ) );

__Fast__.start	= true;
__Fast__.call_events( __Fast__.CREATE );
