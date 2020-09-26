cycle	= 100;
total	= 0;
event	= new Eventer( FAST.STEP_BEGIN, 0, cycle, function( _cycle ) {
	if ( --cycle == 0 ) {
		syslog( "Took ", string_format( total / _cycle / 1000000, 0, 5 ), " seconds." );
		syslog( "Execution stack is ", global.eng.executionStack.empty() ? "empty." : "not empty." );
		syslog( "Variable stack is ", global.eng.stack.empty() ? "empty." : "not empty." );
		
		return event.discard();
		
	}
	var _repeat	= 100;
	
	timer.reset();
	
	repeat( _repeat ) {
		global.eng.execute( "testA", 0 );
	
		if ( global.eng.executionStack.empty() ) {
			while ( global.eng.parseQueue.empty() == false ) {
				syslog( global.eng.parseQueue.dequeue() );
				
			}
			
		}
		global.eng.stack.pop();
		
	}
	total	+= timer.elapsed() / _repeat;
	
});
