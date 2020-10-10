/// @func FAST_Event
/// @param FAST.event
/// @param delay
/// @param parameters
/// @param function
/// @desc	Returns an event that will run continuously until discard() is called on it.
function FAST_Event( _event, _delay, _parameters, _function ) constructor {
		static discard	= function() {
		FAST.delete_event( self );
		
	}
	static is		= function( _data_type ) {
		return _data_type == FAST_Event;
		
	}
	static toString	= function() {
		return "FAST_Event : Trigger " + string( tick ) + ", " + string( tock ) + ", Once? " + ( once ? "true" : "false" );
		
	}
	tick	= 0;
	tock	= _delay;
	once	= false;
	func	= _function;
	params	= _parameters;
	list	= _event;
	ignore	= false;
	
	ds_list_add( list, self );
	
}
