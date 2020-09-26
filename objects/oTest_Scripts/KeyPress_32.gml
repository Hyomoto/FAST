//test_Scripts();
if ( event == undefined ) {
	event	= new Eventer( FAST.STEP, 0, undefined, function() {
		if ( event.mode == 0 ) {
			global.eng.execute( "testA", 10, 1 );
			
			timer.reset();
			
			event.mode	 = 1;
			
		} else {
			if ( global.eng.executionStack.empty() ) {
				while ( global.eng.parseQueue.empty() == false ) {
					syslog( global.eng.parseQueue.dequeue() );
					
				}
				syslog( "Execution was ", global.eng.stack.pop() ? "successful." : "unsuccessful." );
				syslog( "Took ", timer, " seconds." );
				syslog( "Execution stack is ", global.eng.executionStack.empty() ? "empty." : "not empty." );
				syslog( "Variable stack is ", global.eng.stack.empty() ? "empty." : "not empty." );
				
				event	= event.discard();
				
			}
			
		}
		
	});
	event.mode	= 0;
	
}
