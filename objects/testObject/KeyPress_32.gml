var _timer	= new Timer( "evaluation took $S seconds", 5 );

global.engine.execute( "test" );

syslog( _timer );
