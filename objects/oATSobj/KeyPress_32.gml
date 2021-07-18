var _pas	= new Script().from_string("temp a\nwhile a > 0\n  put a - 1 into a").timeout( infinity );
var _timer	= new Timer();
var _i		= 0;
var _l		= 10000;
var _r		= 1;
var _f		= 1/60 * 1000000;
var _t		= 0;
var _c		= 0;
var _k		= 1;

repeat( _k ) {
	_timer.reset();
	
	var _i = 0; repeat( _l ) {
		if ( _timer.elapsed() > 16666 ) { break; }
		_pas.execute( _r );
		++_i;
	}
	_t	+= _timer.elapsed();
	_c	+= _i * _r * 6;
	
}
syslog(string_formatted( "{} operations took {:1.4f} seconds.", _c / _k, _t/1000000/_k ));
