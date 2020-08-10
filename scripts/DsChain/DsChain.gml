/// @func DsChain()
function DsChain() constructor {
	static Link	= function( _chain, _value, _last, _next ) constructor {
		static clear	= function() {
			chain	= undefined;
			last	= undefined;
			next	= undefined;
			
		}
		static toString	= function() {
			return string( value );
			
		}
		chain	= _chain;
		value	= _value;
		last	= _last;
		next	= _next;
		
	}
	static first	= function() {
		// return head
		return head;
		
	}
	static last		= function() {
		// return tail
		return tail;
		
	}
	static find		= function( _value ) {
		// start at head
		var _seek	= head;
		// while there are more links to check
		while ( _seek != undefined ) {
			// does this link contain the given value?
			if ( _seek.value == _value ) {
				return _seek;
				
			}
			// otherwise, set next link to check
			_seek	= _seek.next;
			
		}
		// no link was found
		return undefined;
		
	}
	static remove	= function( _link ) {
		// check if link is part of this chain
		if ( _link.chain != self ) { return; }
		// if this is the only link in this chain
		if ( size == 1 ) {
			head	= undefined;
			tail	= undefined;
		// if this link is the head
		} else if ( _link == head ) {
			head	= _link.next;
			head.last	= self;
		// if this link is the tail
		} else if ( _link == tail ) {
			tail	= _link.last;
			tail.next	= undefined;
		// if this link is inside the chain
		} else {
			_link.last.next	= _link.next;
			_link.next.last	= _link.last;
			
		}
		// clear the link
		_link.clear();
		// shrink the chain
		--size;
		
	}
	static add		= function( _value ) {
		var _last	= ( tail == undefined ? self : tail );
		var _link	= new Link( self, _value, _last, undefined );
		
		if ( _last == self ) {
			head	= _link;
			
		} else {
			tail.next	= _link;
			
		}
		tail	= _link;
		++size;
		
		return _link;
		
	}
	static toArray	= function() {
		var _array	= array_create( size );
		var _next	= head;
		
		var _i = 0; repeat( size ) {
			_array[ _i++ ]	= _next.value;
			
			_next	= _next.next;
			
		}
		return _array;
		
	}
	static toString	= function() {
		return string( toArray() );
		
	}
	head	= undefined;
	tail	= undefined;
	size	= 0;
	
}
