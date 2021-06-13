/// @func DeltaEvent
/// @param {list}	FAST.event	The event to add this to
/// @param {int}	delay		How many seconds before firing
/// @param {func}	function	The function to call when the delay has passed
/// @desc	Creates a new event that relies on frame timing, and will run at the given periodicity during
//		the specified event. The FAST.events are:
//
//#### FAST.CREATE, FAST.GAME_END, FAST.ROOM_START, FAST.ROOM_END, FAST.STEP_BEGIN, FAST.STEP, FAST.STEP_END
/// @example
//event = new DeltaEvent( FAST.STEP, 1, function() {
//    show_debug_message( "Hello World!" );
//});
/// @output Hello World! is written to the console every one seconds.
/// @wiki Core-Index Constructors
function DeltaEvent( _event, _delay, _function ) : FrameEvent( _event, _delay, _function ) constructor {
	/// @desc	Called to update the event.
	static update	= function() {
		__Tick	+= delta_time;
		
		if ( __Tick >= __Tock ) {
			trigger();
			
			__Tick	-= __Tock;
			
		}
		
	}
	/// @var {int}	What tick this event should fire on
	__Tock	*= 1000000;
	
	__Type__.add( DeltaEvent );
	
}
