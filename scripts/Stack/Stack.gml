/// @func Stack
/// @desc	A garbage-collected alternative to the built-in stack. While {#LinkedList} can also be used
///		effectively as a queue or list, this structure provides only those two functions using the
///		terminology that is common to the data type.
function Stack() constructor {
	/// @param {mixed}	values...	Values to push
	/// @desc	Adds the values in order to the top of the stack.
	/// @returns self
	static push	= function() {
		var _i = 0; repeat( argument_count ) {
			__Stack	= { value: argument[ _i ], next: __Stack }
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
		
		__Stack	= __Stack.next;
		__Size	-= 1;
		
		return _value;
		
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
	/// @var {strict}	A value that is returned when the stack is empty
	static EOS	= {}
	/// @var {struct}	The value at the top of the stack.
	__Stack	= undefined;
	/// @var {int}		The size of the stack
	__Size	= 0;
	
}
