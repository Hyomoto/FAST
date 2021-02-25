/// @func FrameEvent
/// @param {list}	FAST.event	The event to add this to
/// @param {int}	delay		How many frames before firing
/// @param {mixed}	parameters	A value to pass to the function
/// @param {func}	function	The function to call when the delay has passed
/// @desc	Creates a new event that relies on frame timing, and will run at the given periodicity during
//		the specified event. The FAST.events are:
//
//#### FAST.CREATE, FAST.GAME_END, FAST.ROOM_START, FAST.ROOM_END, FAST.STEP_BEGIN, FAST.STEP, FAST.STEP_END
/// @example
//event = new FrameEvent( FAST.STEP, 30, undefined, function() {
//    show_debug_message( "Hello World!" );
//}).once();
/// @output Hello World! is written to the console after 30 frames.
/// @wiki Core-Index Events
function FrameEvent( _event, _delay, _parameters, _function ) constructor {
	/// @desc Called to update the event during the event it was assigned to.
	static update	= function() {
		if ( ++tick >= tock ) {
			now();
			
			tick	= 0;
			
		}
		
	}
	/// @desc Executes the event, can be used to force the event to happen now. Can be called when the
	//		event is created, as it will return the event.
	static now		= function() {
		if ( ignore == false && func != undefined ) {
			func( params );
			
		}
		if ( repeats == false ) {
			discard();
			
		}
		return self;
		
	}
	/// @desc Tells the event it should only be run once. Can be called when the event is created,
	//		as it will return the event.
	/// @returns `self`
	static once		= function() {
		repeats	= false;
		
		return self;
		
	}
	/// @desc Destroys the event.
	static discard	= function() {
		func	= undefined;
		
		FAST.discard.enqueue( self );
		
	}
	/// @desc Returns the event as a string, for debugging.
	static toString	= function() {
		return "FrameEvent : Trigger " + string( tick ) + ", " + string( tock ) + ", Once? " + ( once ? "true" : "false" );
		
	}
	static is		= function( _data_type ) {
		return _data_type == FrameEvent;
		
	}
	/// @desc how many frames have passed since event creation/restart.
	tick	= 0;
	/// @desc What tick this event should fire on
	tock	= _delay;
	/// @desc if `true`, will loop after the event fires. otherwise it is discarded.
	repeats	= true;
	/// @desc the function this event calls
	func	= _function;
	/// @desc the parameters that are passed to the function
	params	= _parameters;
	/// @desc the event list this event was added to
	list	= _event;
	/// @desc if `true`, this event will not fire, it will still cycle and/or discard
	ignore	= false;
	
	ds_list_add( list, self );
	
}
