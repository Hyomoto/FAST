/// @func Script
function Script() : DsChain() constructor {
	static toString	= function() {
		return source;
		
	}
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
	static clearSuper	= clear;
	static clear	= function() {
		final	= undefined;
		
		clearSuper();
		
	}
	static validate	= function() {
		var _errors	= 0;
		var _open	= 0;
		var _last	= undefined;
		
		repeat( links ) {
			_last	= next( _last );
			
			if ( _last.close ) { --_open; }
			if ( _last.open ) { ++_open; }
			
		}
		
	}
// # Variable Declaration
	source	= undefined;
	final	= undefined;
	args	= undefined;
	
}
