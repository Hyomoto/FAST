/// @func publisher_unsubscribe
/// @func channels...
function publisher_unsubscribe() {
	static instance	= PublisherManager();
	
	for ( var _i = 0; _i < argument_count; ++_i ) {
		instance.listener_remove( self, argument[ _i ] );
		
	}
	
}
