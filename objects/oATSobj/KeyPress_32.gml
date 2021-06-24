var _timer	= new Timer();
var _script	= new Script().from_input( new TextFile().open( "test.txt" )).timeout(infinity);
var _loop	= 100;
var _total	= 0;

//repeat( 10 ) {
	_timer.reset();
	
	repeat( _loop ) {
		var _hold	= _script.execute(undefined, undefined, 100 );
		_script.__pool__.put( _hold );
	}
	_total	+= _timer.elapsed();
	
	syslog( "ObjectPool size was ", _script.__pool__.size() );
	
//
syslog( "Scripts GML ", _loop * 100,": ", string_from_time( _total/1000000, "$S.SSSS seconds" ));
