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
	/// @desc An interface for copying building copy functions for DsChain-derived data structures.
	/// @param {Struct}			the structure that will be copied to, or `undefined` if a new one should be created
	/// @param {constructor}	the type of structure that should be created if one isn't provided
	/// @param {string}			the function that should be called to populate the new structure
	/// @desc	Returns a copy of this DsChain, or copies to `target` if provided.
	/// #returns struct
	static copy		= function( _const, _func ) {
		var _data	= toArray();
		var _target	= new _const();
		
		with ( _target ) {
			_func	= variable_struct_get( self, _func );
			
			var _i = 0; repeat ( array_length( _data ) ) {
				_func( _data[ _i++ ] );
				
			}
			
		}
		return _target;
		
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
			if ( _i != 0 ) { _string += _divider; }
			
			_string	+= string( _next.value );
			
			_next	= _next.chain;
			
			++_i;
			
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
