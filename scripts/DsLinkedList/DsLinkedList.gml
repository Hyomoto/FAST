/// @func DsLinkedList
/// @param values...
function DsLinkedList() : DsChain() constructor {
// # Method Declaration
	static remove		= function( _link ) {
		if ( links == 0 ) { return; }
		
		var _seek	= chain;
		var _last	= undefined;
		
		while ( _seek != undefined ) {
			if ( _seek == _link ) {
				if ( _link == step ) {
					next();
					
				}
				if ( _last != undefined ) {
					_last.chain	= _link.chain;
					
				}
				if ( _link == chain ) {
					chain	= _link.chain;
					
				}
				if ( _link == final ) {
					final	= _last;
					
				}
				--links;
				
				return true;
				
			}
			_last	= _seek;
			_seek	= _seek.chain;
			
		}
		return false;
		
	}
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
		
		var _func	= ( argument_count > 1 ? argument[ 1 ] : function( _a, _b ) { return _a == _b; } );
		var _seek	= chain;
		
		while ( _seek != undefined ) {
			if ( _func( _seek.value, _value ) ) {
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

	static is		= function( _data_type ) {
		return _data_type == DsLinkedList;
		
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
