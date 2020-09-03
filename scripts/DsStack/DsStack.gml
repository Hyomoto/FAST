/// @func DsStack
/// @param values...
function DsStack() : DsChain() constructor {
	/// @func push
	/// @param values...
	static push	= function() {
		var _i = 0; repeat( argument_count ) {
			var _link	= new ChainLink( argument[ _i++ ] );
			
			_link.chain	= chain;
			
			chain	= _link;
			
			++links;
			
		}
		
	}
	static top	= function() {
		if ( chain == undefined ) { return undefined; }
		
		return chain.value;
		
	}
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
