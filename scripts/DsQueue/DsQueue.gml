/// @func DsQueue
/// @param values...
function DsQueue() : DsChain() constructor {
	static enqueue_at_head	= function() {
		var _i = 0; repeat( argument_count ) {
			var _link	= new ChainLink( argument[ _i++ ] );
			
			if ( links > 0 ) {
				_link.chain	= chain;
				
			}
			chain		= _link;
			
			++links;
			
		}
		
	}
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
	static is		= function( _data_type ) {
		return _data_type == DsQueue;
		
	}
	last	= self;
	
	var _i = 0; repeat( argument_count ) {
		enqueue( argument[ _i++ ] );
		
	}
	
}