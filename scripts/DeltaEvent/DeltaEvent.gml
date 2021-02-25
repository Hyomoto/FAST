/// @func DeltaEvent
/// @param {list}	FAST.event	The event to add this to
/// @param {int}	delay		How many seconds before firing
/// @param {mixed}	parameters	A value to pass to the function
/// @param {func}	function	The function to call when the delay has passed
/// @desc	Creates a new event that relies on frame timing, and will run at the given periodicity during
//		the specified event. The FAST.events are:
//
//#### FAST.CREATE, FAST.GAME_END, FAST.ROOM_START, FAST.ROOM_END, FAST.STEP_BEGIN, FAST.STEP, FAST.STEP_END
/// @example
//event = new DeltaEvent( FAST.STEP, 1, undefined, function() {
//    show_debug_message( "Hello World!" );
//});
/// @output Hello World! is written to the console every one seconds.
/// @wiki Core-Index Events
function DeltaEvent( _event, _delay, _parameters, _function ) : FrameEvent( _event, _delay, _parameters, _function ) constructor {
	/// @override
	static update	= function() {
		tick	+= delta_time;
		
		if ( tick >= tock ) {
			if ( ignore == false && func != undefined ) {
				func( params );
				
			}
			if ( repeats == false ) {
				discard();
				
			}
			tick	-= tock;
			
		}
		
	}
	/// @desc how many microseconds have passed since event creation/restart.
	tick	= 0;
	/// @desc The number of microseconds after which this event should fire.
	tock	*= 1000000;
	
}
