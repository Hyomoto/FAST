/// @func Queue
/// @desc	Am alternative to the built-in queue. It makes use of a simple linked list to provide
///		a fast, cheap, garbage-collected queue.
/// @wiki Core-Index Data Structures
function Queue() : __Struct__() constructor {
	static __pool__	= new ObjectPool();
	/// @param {mixed}	values...	Values to add to the queue
	/// @desc	Pushes the values to the queue in order.
	/// @returns self
	static push	= function() {
		var _i = 0; repeat( argument_count ) {
			var _link	= __pool__.get();
			
			_link.value	= argument[ _i++ ];
			_link.next	= undefined;
			
			if ( __First == undefined ) {
				__First = _link;
				__Last	= _link;
				
			} else {
				__Last.next	= _link;
				__Last		= _link;
				
			}
			__Size	+= 1;
			
		}
		return self;
		
	}
	/// @desc	Pops the first value added to the queue, or EOQ if it is empty.
	/// @returns mixed
	static pop	= function() {
		if ( is_empty() ) { return EOQ; }
		
		var _value	= __First.value;
		
		__First	= __pool__.put( __First ).next;
		__Size	-= 1;
		
		return _value;
		
	}
	/// @desc	Returns the value at the head of the queue, or EOQ if it is empty.
	/// @returns mixed
	static peek	= function() {
		if ( __Size == 0 ) { return EOQ; }
		
		return __First.value;
		
	}
	/// @desc	Returns the head of the queue
	/// @desc	Returns true if the queue is empty.
	/// @returns bool
	static is_empty	= function() {
		return size() == 0;
		
	}
	/// @desc	Returns the number of elements in the queue.
	/// @returns int
	static size	= function() {
		return __Size;
		
	}
	/// @desc	Returns the contents of the stack as a string
	static toString	= function() {
		var _str	= "";
		
		var _node	= __First; repeat( size() ) {
			if ( _str != "" ) { _str += ","; }
			_str	+= string( _node.value );
			_node	= _node.next;
			
		}
		return "[ " + _str + " ]";
		
	}
	/// @var {strict}	A value that is returned when the queue is empty
	static EOQ	= {};
	/// @var {struct}	A pointer to the first node in the queue
	__First	= undefined;
	/// @var {struct}	A pointer to the last node in the queue
	__Last	= undefined;
	/// @var {int}	The number of nodes in the queue
	__Size	= 0;
	
	__Type__.add( __Stream__ );
	__Type__.add( Queue );
	
}
