var _timer	= new Timer( "$S", 5 );

global.eng.run_script( "test" );

syslog( "Execute took ", _timer, " seconds." );
