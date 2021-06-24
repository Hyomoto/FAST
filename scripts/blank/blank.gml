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
RenderManager.set_resolution( 1280, 720 );
RenderManager.set_overscan( 0, 16 );
RenderManager.create_camera( 640, 360 );
RenderManager.camera.set_offset( 320, 180 );


//syslog( RenderManager.camera.__Event.__Param );

/// @func ease_in_circ
/// @param {float}	t	A float 0.0 - 1.0
/// @desc	An easing function.  Check <https://easings.net/> for examples on how these functions
///		behave.
function ease_in_circ( _x ) {
	return 1 - sqrt(1 - power(_x, 2));
}
function ease_out_circ( _x ) {
	return sqrt(1 - power(_x - 1, 2));
}
