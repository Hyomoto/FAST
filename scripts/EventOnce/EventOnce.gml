/// @func EventOnce
/// @param FAST.event
/// @param delay
/// @param parameters
/// @param function
function EventOnce( _event, _delay, _parameters, _function ) constructor {
	static clear	= function() {
		ignore	= true;
		once	= true;
		tock	= 0;
		// used to clear the event on the caller, if needed
		return undefined;
		
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
