fast	= FASTManager();

if ( fast.start ) {
	syslog( "dupe found, death for me." );
	
	instance_destroy();
	
	exit;
	
}
System.write( string_repeat( "~", 40 ) );
System.write( fast );
System.write( string_repeat( "~", 40 ) );

var _i = 0; repeat( ds_list_size( fast.features ) ) {
	var _feature	= fast.features[| _i++ ];
	
	syslog( _feature );
	
}
fast.start	= true;
fast.call_events( fast.CREATE );
