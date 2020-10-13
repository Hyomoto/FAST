/// @func event_create
/// @param FAST.event
/// @param delay
/// @param parameters
/// @param function
/// @param *once
/// @desc	Returns an event that will run once during the specified event
/// @wiki Core-Index Events
function event_create( _list, _delay, _parameters, _function ) {
	var _event	= new FAST_Event( _list, _delay, _parameters, _function );
	
	if ( argument_count > 4 ? argument[ 4 ] : false ) {
		_event.once	= true;
		
	}
	return _event;
	
}
