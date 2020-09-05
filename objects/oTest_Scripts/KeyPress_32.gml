//test_Scripts();
if ( global.eng.is_waiting() == false ) {
	global.eng.run_script( "testA" );
	
} else {
	global.eng.proceed();
	
}
while ( global.eng.has_next() || global.eng.parser.has_next() ) {
	syslog( global.eng.parser.next_line() );
	
	if ( global.eng.has_next() ) {
		global.eng.next();
		
	}
	
}
