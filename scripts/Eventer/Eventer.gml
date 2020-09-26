/// @func Eventer
/// @param FAST.event
/// @param delay
/// @param parameters
/// @param function
/// @desc	Returns an event that will run continuously until discard() is called on it.
function Eventer( _event, _delay, _parameters, _function ) : EventerOnce( _event, _delay, _parameters, _function ) constructor {
	once	= false;
	
}
