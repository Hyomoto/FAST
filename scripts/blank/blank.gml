//syslog( string_repeat( "~", 72 ) )
//syslog( "\t\tDATABASE TEST" );

//syslog( string_repeat( "~", 72 ) )

//var _data	= new Database();
//syslog( "write" );
//_data.write( "foo.bar", 0, FAST_DB_IDS.NODE );
//_data.write( "foo.bar", "jello world!" );
//_data.remove( "foo" );
//syslog( "output" );
//show_debug_message( _data.toString() );
repeat ( 100 ) {
	var _a	= irandom( 360 );
	var _b	= irandom( 360 );
	var _angle	= irandom( 360 );
	
	syslog( _angle, angle_is_between( _a, _b, _angle ) ? " is " : " is NOT ", "between ", _a, " and ", _b );
	
}
