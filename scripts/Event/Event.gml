/// @func Event
/// @param FAST.event
/// @param delay
/// @param parameters
/// @param function
/// @desc	Returns an event that will run continuously until discard() is called on it.
function Event( _event, _delay, _parameters, _function ) : EventOnce( _event, _delay, _parameters, _function ) constructor {
	once	= false;
	
}
