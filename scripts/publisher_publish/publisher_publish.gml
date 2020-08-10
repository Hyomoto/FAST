/// @func publisher_publish
/// @param channel
/// @param message
function publisher_publish( _channel, _message ) {
	static instance	= PublisherManager();
	
	instance.listener_notify( _channel, _message );
	
}
