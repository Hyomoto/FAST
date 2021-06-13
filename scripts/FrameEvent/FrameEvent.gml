/// @func FrameEvent
/// @param {int}	event		The event this should happen during
/// @param {int}	delay		How many frames before firing
/// @param {func}	function	The function to call when the delay has passed
/// @desc	Creates a new event that will be updated based on delta time.  After the time has elapsed
///		the event will be triggered.  If the event is flagged to only happen once, it will be discarded
///		afterwards, otherwise it will start the counter over again.\n
/// * FAST.CREATE
/// * FAST.GAME_END
/// * FAST.ROOM_START
/// * FAST.ROOM_END
/// * FAST.STEP_BEGIN
/// * FAST.STEP
/// * FAST.STEP_END
/// * FAST.ASYNC_SYSTEM
/// @example
//event = new FrameEvent( FAST.STEP, 30, function() {
//    show_debug_message( "Hello World!" );
//}).once();
/// @output Hello World! is written to the console after 30 frames.
/// @wiki Core-Index Constructors
function FrameEvent( _event, _delay, _function ) : __Struct__() constructor {
	/// @desc	Called to update the event.
	static update	= function() {
		if ( ++__Tick >= __Tock ) {
			trigger();
			
			__Tick	= 0;
			
		}
		
	}
	/// @desc Triggers the event to happen now.  This does not affect timing, but if the
	///		event is set to happen once, it will cause it to be discarded as well.
	/// @returns self
	static trigger	= function() {
		if ( __Ignore == false && __Func != undefined )
			__Func( __Param );
		
		if ( __Repeat == false )
			discard();
		
		return self;
		
	}
	/// @desc	Flags the event to only be performed once.  Once triggered, either by timing or manually,
	///		the event will be discarded.
	/// @returns self
	static once		= function() {
		__Repeat	= false;
		
		return self;
		
	}
	/// @desc	Discards the event from the FAST event system.  Note: if you maintain the reference to
	///		the event it will still exist and can be updated or triggered manually.  Discarding only
	///		removes it from the FAST event system.
	static discard	= function() {
		__Func	= undefined;
		
		ds_queue_enqueue( FAST.discard, self );
		
		return self;
		
	}
	/// @param {mixed}	parameter	The parameter to pass
	/// @desc	Sets the event parameter that will be passed into the function when it is triggered.
	/// @returns self
	static parameter	= function( _parameter ) {
		__Param	= _parameter;
		
		return self;
		
	}
	/// @desc Returns the event as a string, for debugging.
	static toString	= function() {
		return "FrameEvent : Trigger " + string( __Tick ) + ", " + string( __Tock ) + ", Once? " + ( once ? "true" : "false" );
		
	}
	if ( is_numeric( _delay ) == false ) { throw new InvalidArgumentType( instanceof( self ), 1, _delay, "int" ); }
	if ( is_method( _function ) == false ) { throw new InvalidArgumentType( instanceof( self ), 2, _function, "method" ); }
	
	/// @var {int}	How many frames have passed since event creation/restart.
	__Tick	= 0;
	/// @var {int}	What tick this event should fire on
	__Tock	= _delay;
	/// @var {bool}	If `true`, will loop after the event fires. otherwise it is discarded.
	__Repeat= true;
	/// @var {method}	The function this event calls
	__Func	= _function;
	/// @var {int}	The event during which the function will be triggered
	__Event	= _event;
	/// @var {bool}	If `true`, this event will not fire, it will still cycle and/or discard.
	__Ignore= false;
	/// @var {mixed}	A value that will be passed into the event when triggered
	__Param	= undefined;
	
	try {
		if ( FAST_DISABLE_EVENTS == false ) 
			ds_list_add( __Event, self );
			
	} catch( _ex ) {
		throw new InvalidArgumentType( instanceof( self ), 0, _event, "FAST_EVENT" );
		
	}
	__Type__.add( FrameEvent );
	
}
