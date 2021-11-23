x	+= 1;
y	+= 0.5;
if ( gamepad_button_check_pressed( 0, gp_face1 ))
	syslog( "BEEP" );
var _scroll	= mouse_wheel_up() - mouse_wheel_down();

if ( _scroll != 0 ) {
	start	= max( start + _scroll, 0 );
	surface.redraw();
	
}
if ( waitFor > 0 ) { --waitFor; return; }

if ( running != undefined ) {
	running.timer.reset();
	
	while ( running.timer.elapsed() < stepSpeed && running.index < array_length( running.list ) ) {
		__test_start( running.list[ running.index++ ] );
		running.errors	+= __test_failures;
		
	}
	if ( running.index == array_length( running.list ) ) {
		print( "##### TEST COMPLETED #####" );
		print( "Total Time:     " + string_from_time( timer.elapsed() / 1000000, "$S.SSSs" ) );
		print( "Total Tests:    " + string( running.tested ));
		print( "Total Errors:   " + string( running.errors ));
		print( "Total Warnings: " + string( __warnings ));
		
		running	= undefined;
		
		return;
		
	}
	
}
