var _timer	= new Timer( "$S", 5 );
syslog( "Running test..." );

test_Scripts();


//global.eng.do_function( "test_if" );
syslog( "execution took ", _timer, " seconds" );
