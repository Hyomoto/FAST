/// @func DsQueue
/// @param {mixed} values...	The initial values to be pushed to the queue
/// @desc A garbage-collected queue.
/// @example
//queue = new DsQueue()
//
//queue.enqeue( "Hello!" )
//show_debug_message( queue.dequeue() );
/// @wiki Core-Index Data Structures
function DsQueue() : DsChain() constructor {
	/// @param {mixed} values... Enqueues the values at the tail of the queue
	static enqueue	= function() {
		var _i = 0; repeat( argument_count ) {
			var _link	= new ChainLink( argument[ _i++ ] );
			
			tail_link.chain	= _link;
			tail_link		= _link;
			
			++links;
			
		}
		
	}
	/// @param {mixed} values... Enqueues the values at the head of the queue
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
	/// @param {mixed} values... Removes the value at the front of the queue and returns it
	/// @returns Mixed
	static dequeue	= function() {
		if ( chain == undefined ) { return undefined; }
		
		var _link	= chain;
		
		chain	= _link.chain;
		
		if ( chain == undefined ) {
			tail_link	= self;
			
		}
		--links;
		
		return _link.value;
		
	}
	/// @param {mixed} values... Returns the value at the head of the queue
	/// @returns Mixed
	static head	= function() {
		if ( chain == undefined ) { return undefined; }
		
		return chain.value;
		
	}
	/// @param {mixed} values... Removes the value at the tail of the queue and returns it
	/// @returns Mixed
	static tail	= function() {
		if ( tail_link == self ) { return undefined; }
		
		return tail_link.value;
		
	}
	/// @override
	static clearSuper	= clear;
	/// @override
	static clear	= function() {
		tail_link	= self;
		
		clearSuper();
		
	}
	static is		= function( _data_type ) {
		return _data_type == DsQueue;
		
	}
	/// @desc the value at the tail_link of the queue
	tail_link	= self;
	
	var _i = 0; repeat( argument_count ) {
		enqueue( argument[ _i++ ] );
		
	}
	
}