/// @func publisher_broadcast
/// @param channel
/// @param message
function publisher_broadcast( _channel, _message ) {
	static instance	= PublisherManager();
	
	instance.listener_notify( _channel, _message );
	
}