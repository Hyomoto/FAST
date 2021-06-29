/// @func Stack
/// @desc	Am alternative to the built-in stack. It makes use of a simple linked list to provide
///		a fast, cheap, garbage-collected stack.
/// @wiki Core-Index Data Structures
function Stack() : __Struct__() constructor {
	static __pool__ = new ObjectPool();
	/// @param {mixed}	values...	Values to push
	/// @desc	Adds the values in order to the top of the stack.
	/// @returns self
	static push	= function() {
		var _i = 0; repeat( argument_count ) {
			var _get	= __pool__.get();
			
			_get.value	= argument[ _i++ ];
			_get.next	= __Stack;
			
			__Stack	= _get;
			__Size	+= 1;
			
		}
		return self;
		
	}
	/// @desc	Pops the value off the top of the stack and returns it.  If the stack is empty,
	///		EOS is returned instead.
	/// @returns mixed or EOS
	static pop	= function() {
		if ( __Size == 0 ) { return EOS; }
		
		var _value	= __Stack.value;
		var _stack	= __Stack;
		
		__Stack	= __Stack.next;
		__Size	-= 1;
		
		__pool__.put( _stack ).next	= undefined;
		
		return _value;
		
	}
	/// @desc	Peeks at the top value of the stack and returns it.  If the stack is empty,
	///		EOS is returned instead.
	/// @returns mixed or EOS
	static peek	= function() {
		if ( __Size == 0 ) { return EOS; }
		
		return __Stack.value;
		
	}
	/// @desc	Returns true if the stack is empty.
	/// @returns bool
	static is_empty	= function() {
		return __Size == 0;
		
	}
	/// @desc	Returns the size of the stack.
	/// @returns int
	static size	= function() {
		return __Size;
		
	}
	/// @desc	Returns the contents of the stack as a string
	static toString	= function() {
		var _str	= "";
		
		var _node	= __Stack; repeat( size() ) {
			if ( _str != "" ) { _str += ","; }
			_str	+= string( _node.value );
			_node	= _node.next;
			
		}
		return "[ " + _str + " ]";
		
	}
	/// @var {strict}	A value that is returned when the stack is empty
	static EOS	= {}
	/// @var {struct}	A pointer to the next node in the stack
	__Stack	= undefined;
	/// @var {int}	The number of nodes in the stack
	__Size	= 0;
	
	__Type__.add( __Stream__ );
	__Type__.add( Stack );
	
}
