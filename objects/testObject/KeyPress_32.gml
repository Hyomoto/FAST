var _timer	= new Timer( "$S", 5 );
syslog( "Running test..." );

event_user( 0 );


//global.eng.do_function( "test_if" );
syslog( "execution took ", _timer, " seconds" );
