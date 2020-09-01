/// @func DsLinkedList
/// @param values...
function DsLinkedList() : DsChain() constructor {
// # Method Declaration
	static first	= function() {
		if ( links == 0 ) { return undefined; }
		
		return chain;
		
	}
	static has_next	= function( _last ) {
		return ( links == 0 ? false : _last == undefined || _last.chain != undefined );
		
	}
	static next		= function( _last ) {
		if ( links == 0 ) { return undefined; }
		if ( _last == undefined || _last.chain == undefined ) {
			_last	= chain;
			
		} else {
			_last	= _last.chain;
			
		}
		return _last;
		
	}
	static find	= function( _value ) {
		if ( links == 0 ) { return undefined; }
		
		var _seek	= chain;
		
		while ( _seek != undefined ) {
			if ( _seek.value == _value ) {
				return _seek;
				
			}
			_seek	= _seek.chain;
			
		}
		return undefined;
		
	}
	static add	= function( _value ) {
		var _link	= new ChainLink( _value );
		
		if ( final == undefined ) { 
			chain		= _link;
			
		} else {
			final.chain	= _link;
			
		}
		final		= _link;
		
		++links;
		
		return _link;
		
	}
	static clear_DsChain	= clear;
	static clear	= function() {
		final	= undefined;
		
		clear_DsChain();
		
	}
// # Variable Declaration
	final	= undefined;
	
	var _i = 0; repeat( argument_count ) {
		add( argument[ _i++ ] );
		
	}
	
}
