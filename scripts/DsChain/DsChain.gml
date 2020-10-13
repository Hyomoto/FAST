/// @func DsChain
/// @desc	inheritable template, provides a standardized way for dealing with
///		structures that can be written to
/// @wiki Core-Index Data Structures
function DsChain() constructor {
	static ChainLink	= function( _value ) constructor {
		static toString	= function() {
			return "ChainLink(" + string( value ) + ")";
			
		}
		value	= _value;
		chain	= undefined;
		
	}
	static clear	= function() {
		chain	= undefined;
		links	= 0;
		
	}
	static empty	= function() {
		return links == 0;
		
	}
	static size		= function() {
		return links;
		
	}
	
	static is		= function( _data_type ) {
		return _data_type == DsChain;
		
	}
	static toArray	= function() {
		var _array	= array_create( links );
		var _next	= chain;
		
		var _i = 0; repeat( links ) {
			_array[ _i++ ]	= _next.value;
			
			_next	= _next.chain;
			
		}
		return _array;
		
	}
	static toString	= function() {
		return string( toArray() );
		
	}
	chain	= undefined;
	links	= 0;
	
}
