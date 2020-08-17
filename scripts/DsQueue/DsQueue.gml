/// @func DsQueue
/// @param values...
function DsQueue() : DsChain() constructor {
	/// @func push
	/// @param values...
	static enqueue	= function() {
		var _i = 0; repeat( argument_count ) {
			var _link	= new ChainLink( argument[ _i++ ] );
			
			last.chain	= _link;
			last		= _link;
			
			++links;
			
		}
		
	}
	static dequeue	= function() {
		if ( chain == undefined ) { return undefined; }
		
		var _link	= chain;
		
		chain	= _link.chain;
		
		if ( chain == undefined ) {
			last	= self;
			
		}
		--links;
		
		return _link.value;
		
	}
	static head	= function() {
		if ( chain == undefined ) { return undefined; }
		
		return chain.value;
		
	}
	static tail	= function() {
		if ( last == self ) { return undefined; }
		
		return last.value;
		
	}
	static clearSuper	= clear;
	static clear	= function() {
		last	= self;
		
		clearSuper();
		
	}
	var _i = 0; repeat( argument_count ) {
		enqueue( argument[ _i++ ] );
		
	}
	last	= self;
	
}