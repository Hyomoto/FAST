/// @func DsChain
/// @desc	inheritable template, provides a standardized interface for dealing with linked
///		data structures
/// @wiki Core-Index Data Structures
function DsChain() constructor {
	/// @param {mixed} value The value to store
	/// @desc A structure for holding and linking values as part of a DsChain.
	/// @returns ChainLink
	static ChainLink	= function( _value ) constructor {
		static toString	= function() {
			return "ChainLink(" + string( value ) + ")";
			
		}
		value	= _value;
		chain	= undefined;
		
	}
	/// @desc Clears the chain, removing all links.
	static clear	= function() {
		chain	= undefined;
		links	= 0;
		
	}
	/// @desc Returns `true` if the structure has no links.
	/// @returns bool
	static empty	= function() {
		return links == 0;
		
	}
	/// @desc Returns the number of links in the structure.
	static size		= function() {
		return links;
		
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
	/// @desc Returns a comma-separated string(by default) of all values in the array.
	/// @param {string} divider optional: The divider between each element. Default: ", "
	static toString	= function( _divider ) {
		if ( _divider == undefined ) { _divider = ", "; }
		
		var _next	= chain;
		var _string	= "";
		
		var _i = 0; repeat( links ) {
			_string	+= string( _next.value );
			
			_next	= _next.chain;
			
		}
		return _string;
		
	}
		static is		= function( _data_type ) {
		return _data_type == DsChain;
		
	}
	/// @desc the first link the chain
	chain	= undefined;
	/// @desc the number of links in the chain
	links	= 0;
	
}
