/// @func Publisher
function Publisher() : DsChain() constructor {
	static notify	= function( _message ) {
		var _seek	= head;
		
		while ( _seek != undefined ) {
			_seek.func( _message );
			_seek	= _seek.next;
			
		}
		
	}
	static subscribe	= function( _value, _function ) {
		var _link	= add( _value );
		
		_link.func	= _function;
		
		return _link;
		
	}
	static unsubscribe	= function( _value ) {
		var _link	= find( _value );
		
		if ( _link != undefined ) {
			remove( _link );
			
		}
		
	}
	
}
