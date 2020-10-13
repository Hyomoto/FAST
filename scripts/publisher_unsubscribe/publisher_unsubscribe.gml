/// @func publisher_unsubscribe
/// @func channels...
/// @wiki Publisher-Index
function publisher_unsubscribe() {
	static instance	= PublisherManager();
	
	for ( var _i = 0; _i < argument_count; ++_i ) {
		instance.listener_remove( self, argument[ _i ] );
		
	}
	
}
