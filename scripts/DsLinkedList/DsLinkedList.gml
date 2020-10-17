/// @func DsLinkedList
/// @param values...
/// @desc A garbage-collected, linear-traversable linked-list.
/// @wiki Core-Index Data Structures
function DsLinkedList() : DsChain() constructor {
	/// @param {mixed} value The value to add to the list
	/// @desc Adds the given value to the list, and returns the link that contains it.
	/// @returns ChainLink
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
	/// @param {ChainLink} link The link to remove.
	/// @desc Removes the given link from the list
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
	/// @desc Returns the first link in the list.  Returns `undefined` if the list is empty.
	/// @returns ChainLink or `undefined`
	static first	= function() {
		if ( links == 0 ) { return undefined; }
		
		return chain;
		
	}
	/// @param {ChainLink} link The link to check.
	/// @desc Returns if there are more links after the specified one.
	/// @returns bool
	static has_next	= function( _last ) {
		return ( links == 0 ? false : _last == undefined || _last.chain != undefined );
		
	}
	/// @param {ChainLink} link The link to check.
	/// @desc Returns the next link after the specified one, or `undefined` if this is the last one.
	/// @returns ChainLink or `undefined`
	static next		= function( _last ) {
		if ( links == 0 ) { return undefined; }
		if ( _last == undefined || _last.chain == undefined ) {
			_last	= chain;
			
		} else {
			_last	= _last.chain;
			
		}
		return _last;
		
	}
	/// @param {mixed} value The value to check for
	/// @desc Searches the list for the given value and returns the link holding it, or `undefined` if it isn't found.
	/// @return ChainLink or `undefined`
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
	/// @override
	static clear_DsChain	= clear;
	/// @override
	static clear	= function() {
		final	= undefined;
		
		clear_DsChain();
		
	}
	/// @override
	static copy_DsChain		= copy;
	/// @desc	Returns a copy of this DsLinkedList.
	/// @returns (#DsLinkedList)
	static copy		= function() {
		return copy_DsChain( DsLinkedList, "add" );
		
	}
	static is		= function( _data_type ) {
		return _data_type == DsLinkedList;
		
	}
	/// @desc the final link in the list
	final	= undefined;
	
	var _i = 0; repeat( argument_count ) {
		add( argument[ _i++ ] );
		
	}
	
}
