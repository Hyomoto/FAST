//test_Scripts();

if ( global.eng.is_waiting() == false ) {
	timer.reset();
	
	global.eng.run_script( "testA" );
	
} else {
//	global.eng.proceed();
	
}
while ( global.eng.parseQueue.empty() == false ) {
	syslog( global.eng.parseQueue.dequeue() );
	
}
syslog( "Took ", timer, " seconds." );
syslog( "Execution stack is ", global.eng.executionStack.empty() ? "empty." : "not empty." );
