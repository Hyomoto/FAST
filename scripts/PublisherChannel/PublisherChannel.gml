/// @func PublisherChannel
function PublisherChannel() : DsLinkedList() constructor {
	static notify	= function( _message ) {
		var _seek	= next();
		
		repeat ( links ) {
			_seek.value( _message );
			
			_seek	= _seek.next();
			
		}
		
	}
	static is		= function( _data_type ) {
		return _data_type == Publisher;
		
	}
	
}
