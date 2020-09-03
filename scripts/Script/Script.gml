/// @func Script
function Script() : DsChain() constructor {
	static validate	= function( _engine, _quiet ) {
		var _open	= 0;
		var _last	= undefined;
		
		repeat( links ) {
			_last	= next( _last );
			
			if ( is_string( _last.value ) ) { continue; }
			
			_last.value.validate( _engine, self );
			
			if ( _last.value.close ) { --_open; }
			if ( _last.value.open ) { ++_open; }
			
		}
		if ( _open > 0 ) { _engine.errors.push( source + " lacks closures, check for missing 'end' or 'loop'." ); }
		if ( _open < 0 ) { _engine.errors.push( source + " has too many closures, check for extra 'end' or 'loop'." ); }
		
		if ( _quiet == false || _engine.errors.size() > 0 ) {
			_engine.log( source, "Script validated with ", _engine.errors.size(), " errors." );
			
			if ( _engine.errors.size() > 0 ) {
				while ( _engine.errors.size() > 0 ) {
					_engine.log( source, _engine.errors.pop() );
					
				}
				
			}
			
		}
		
	}
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
	static is		= function( _data_type ) {
		return _data_type == Script;
		
	}
// # Variable Declaration
	source	= undefined;
	final	= undefined;
	args	= undefined;
	
}
