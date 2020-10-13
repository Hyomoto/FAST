if ( files.size() > 0 ) {
	var _timer	= new Timer();
	
	repeat( files.size() ) {
		target	= files.dequeue();
		
		trace( "Processing ", target.name, "..." );
		
		event_user( 0 );
		
		target.discard();
		
		if ( _timer.elapsed() > 100000 ) { break; }
		
	}
	if ( files.size() == 0 ) {
		event_user( 3 );
		
		syslog( "Found ", total, ", saved ", final, " with ", errors, " errors.  Check ouput for details." );
		
		table.destroy();
		
	}
	complete	= total - files.size();
	display		= string( complete ) + "/" + string( total );
	perc		= complete / total;
	
	bg.redraw	= true;
	fg.redraw	= true;
	
}
