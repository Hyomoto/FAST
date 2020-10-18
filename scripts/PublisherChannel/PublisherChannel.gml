/// @func PublisherChannel
/// @desc	A simple publisher-subscriber framework.
/// @wiki Core-Index Publisher
function PublisherChannel() : DsLinkedList() constructor {
	/// @override
	static add_DsLinkedList	= add;
	/// @param {func} method The method to add to the list.
	/// @desc Adds the given method to the list, and returns the link that contains it. If the provided
	//		argument is not a method, an error will be logged and the method will not be added.
	/// @returns ChainLink
	static add	= function( _func ) {
		if ( is_method( _func ) == false ) {
			PublisherManager().log( "PublisherChannel.add could not add, \"", string( _func ), "\" because it is not a method. Ignored." );
			return;
		}
		add_DsLinkedList( _func );
		
	}
	/// @param {mixed}	message	The message to pass to the subscribers.
	/// @desc	Calls each of the subscriber methods with `message` as an argument.
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
