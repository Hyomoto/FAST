/// @func DsStack
/// @param {mixed} values...	The initial values to be pushed to the stack.
/// @desc A garbage-collected stack.
/// @example
//stack = new DsStack()
//
//stack.push( "Hello!" )
//show_debug_message( stack.pop() );
/// @wiki Core-Index Data Structures
function DsStack() : DsChain() constructor {
	/// @param {mixed} values... The values to be pushed onto the stack.
	static push	= function() {
		var _i = 0; repeat( argument_count ) {
			var _link	= new ChainLink( argument[ _i++ ] );
			
			_link.chain	= chain;
			
			chain	= _link;
			
			++links;
			
		}
		
	}
	/// @param {mixed} values... Returns the value on top of the stack.
	static top	= function() {
		if ( chain == undefined ) { return undefined; }
		
		return chain.value;
		
	}
	/// @param {mixed} values... Removes the value on top of the stack and returns it.
	static pop	= function() {
		if ( chain == undefined ) { return undefined; }
		
		var _link	= chain;
		
		chain	= _link.chain;
		
		--links;
		
		return _link.value;
		
	}
	static is		= function( _data_type ) {
		return _data_type == DsStack;
		
	}
	var _i = 0; repeat( argument_count ) {
		push( argument[ _i++ ] );
		
	}
	
}
