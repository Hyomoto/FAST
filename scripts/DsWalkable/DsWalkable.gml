/// @func DsWalkable
function DsWalkable() : DsChain() constructor {
	static remove		= function( _link ) {
		var _final	= self;
		var _chain	= chain;
		
		while ( _chain != undefined ) {
			if ( _chain == _link ) {
				if ( _link == final ) { final = _final; }
				
				_final.chain	= _link.chain;
				
				--links;
				
				return true;
				
			}
			_final	= _chain;
			_chain	= _chain.chain;
			
		}
		return false;
		
	}
	static clearSuper	= clear;
	static clear	= function() {
		final	= self;
		step	= self;
		
		clearSuper();
		
	}
	static start	= function( _at ) {
		step	= self;
		
		repeat( _at == undefined ? 0 : _at ) { next(); }
		
	}
	static has_next	= function() {
		return ( links == 0 ? false : ( step.chain == undefined ? false : true ) );
		
	}
	static next		= function() {
		if ( links == 0 ) { return undefined; }
		if ( step.chain == undefined ) {
			step	= self;
			
		}
		step	= step.chain;
		
		return step.value;
		
	}
	static find	= function( _value ) {
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
		
		final.chain	= _link;
		final		= _link;
		
		++links;
		
		return _link;
		
	}
	final	= self;
	step	= self;
	
}