/// @param {function} _function	The function to run on this thread.
/// @param {real} _tickRate		Default: 1 How often to run this thread.
/// @param {bool} _seconds		Default: false. If true, uses seconds instead of frame timing.
function Thread( _function, _tickRate = 1, _seconds = false ) constructor {
	static start	= function() {
		switch ( time_source_get_state( state )) {
			case time_source_state_paused : time_source_resume( state ); break;
			case time_source_state_initial: 
			case time_source_state_stopped: time_source_start( state ); break;
			
		}
		
	}
	static pause	= function() { time_source_pause( state ) }
	static stop		= function() { time_source_stop( state ) }
	static isRunning	= function() {
		return time_source_get_state( state ) == time_source_state_active;
		
	}
	static destroy	= function() {
		stop(); time_source_destroy( state );
		
	}
	state	= time_source_create( time_source_global, _tickRate, _seconds ? time_source_units_seconds : time_source_units_frames, _function, [], -1 );
	start();
	
}
