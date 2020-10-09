/// @func EventOnce
/// @param FAST.event
/// @param delay
/// @param parameters
/// @param function
/// @desc	Returns an event that will run once during the specified event
function EventOnce( _event, _delay, _parameters, _function ) constructor {
	static discard	= function() {
		FAST.delete_event( self );
		
	}
	static is		= function( _data_type ) {
		return _data_type == Event;
		
	}
	static toString	= function() {
		return "Event : Trigger " + string( tick ) + ", " + string( tock ) + ", Once? " + ( once ? "true" : "false" );
		
	}
	tick	= 0;
	tock	= _delay;
	once	= true;
	func	= _function;
	params	= _parameters;
	list	= _event;
	ignore	= false;
	
	ds_list_add( list, self );
	
}
