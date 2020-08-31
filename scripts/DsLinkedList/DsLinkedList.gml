/// @func DsLinkedList
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
	static clearSuper	= clear;
	static clear	= function() {
		final	= undefined;
		step	= undefined;
		steps	= 0;
		
		clearSuper();
		
	}
	static start	= function( _at ) {
		step	= undefined;
		steps	= 0;
		
		repeat( _at == undefined ? 0 : _at ) { next(); }
		
	}
	static first	= function() {
		if ( links == 0 ) { return undefined; }
		
		return chain.value;
		
	}
	static has_next	= function() {
		return ( links == 0 ? false : step == undefined || step.chain != undefined );
		
	}
	static remaining	= function() {
		return links - steps;
		
	}
	static next		= function() {
		if ( links == 0 ) { return undefined; }
		if ( step == undefined || step.chain == undefined ) {
			step	= chain;
			steps	= 1;
			
		} else {
			step	= step.chain;
			steps	+= 1;
			
		}
		return step.value;
		
	}
	static peek	= function() {
		if ( links == 0 ) { return undefined; }
		
		return ( step == undefined ? chain.value : step.value );
		
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
// # Variable Declaration
	final	= undefined;
	step	= undefined;
	steps	= 0;
	
	var _i = 0; repeat( argument_count ) {
		add( argument[ _i++ ] );
		
	}
	
}