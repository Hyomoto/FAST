/// @func Parser
/// @param {method}	skip	A char_ method
/// @desc	The parser is used to break strings into chunks.  By default whitespace will be used to
///		find breaks, but another method can be provided to change this behavior.
/// @example
//var _parser = new StringParser().parse( "Hello World!" )
//
//_parser.next();
/// @output "Hello"
/// @wiki Core-Index Constructors
function Parser() : __InputStream__() constructor {
	/// @param {string}	*string	optional: A string to be parsed
	/// @desc	Sets the provided string to be parsed.  If no string is provided, the last string
	///		will be reused for processing.
	/// @returns self
	/// @throws InvalidArgumentType
	static open	= function( _string ) {
		if ( _string != undefined ) {
			if ( is_string( _string ) == false )
				throw new InvalidArgumentType( "open", 0, _string, "string" );
			__Content	= _string;
			__Size		= string_length( _string );
			__Index		= 0;
			__Level		= -1;
			
		}
		return self;
		
	}
	static close	= function() {}
	static finished	= function() {
		return __Index == __Size;
		
	}
	/// @param {method}	char_func	A char_ function or equivalent method
	/// @param {bool}	*is_true	optional: If false, will invert the comparison
	/// @desc	Reads the next 'word' in the string based on the character function.
	static word	= function( _c, _false ) {
		_false = _false == false;
		
		skip( _c, _false );
		
		if ( finished() )
	        return "";
		
		mark();
		
		var _i = 0; repeat( __Size - __Index ) {
			if ( _c( read()) == _false )
				break;
			++_i;
			
		}
		reset();
		
		__Buffer	= string_copy( __Content, __Index + 1, _i );
		
		advance( _i );
		
		return __Buffer;
		
	}
	/// @param {method}	char_func	A char_ function or equivalent method
	/// @param {bool}	*is_true	optional: If false, will invert the comparison
	/// @desc	Advances the read position in the string as if the character function returns true,
	///		unless is_true is false.
	static skip	= function( _c, _false ) {
		_false = _false == false;
		
		mark();
		
		var _i = 0; repeat( __Size - __Index ) {
			if ( _c( read()) == _false )
				break;
			++_i;
		}
		reset();
		
		advance( _i );
		
	}
	/// @desc	Advances the read position in the string.
	static advance	= function( _c ) {
		__Index	= min( __Size, __Index + _c );
		
	}
	/// @desc	Returns the next character in the string.
	/// @returns char
	static read	= function() {
	    if ( finished() )
	        return END;
        
		__Buffer	= string_char_at( __Content, ++__Index );
		
		return __Buffer;
		
	}
	/// @desc	Returns the next character in the string without advancing the index.
	/// @returns char
	static peek	= function() {
		var _c	= read();
		unread();
		return _c;
		
	}
	/// @desc	Remembers the last read position.
	static mark	= function() {
		__Marks[ ++__Level ] = __Index;
		
	}
	/// @desc	Returns the last marked position and unsets it.
	/// @returns int
	static unmark	= function() {
		if ( __Level < 0 )
		    throw new IndexOutOfBounds( "unmark", __Level, "No marks to unmark.");
		return __Marks[ __Level-- ];
	}
	/// @desc	Returns processing to the last marked position.
	static reset	= function() {
	    __Index = unmark();
		
	}
	/// @desc	Reverses the last read.
	static unread	= function() {
		if ( __Index == 0 )
			throw new IndexOutOfBounds( "unread", __Index, "Can not unread from beginning of string.");
		--__Index;
		
	}
	/// @desc	Returns the parser to a state previously pushed onto the save stack.
	/// @returns self
	static pop	= function( _data ) {
		if ( __State.size() == 0 )
			throw new __Error__().from_string( "No state saved to parser to load!" );
		__Content	= __State.peek().c;
		__Index		= __State.peek().i;
		
		__State.pop();
		
	}
	/// @desc	Saves the current state of the parser to a stack. Can be returned to with load().
	/// @returns struct
	static push	= function() {
		__State.push({ i: __Index, c: __Content });
		
	}
	static END	= {}
	
	__Content	= "";
	__Size		= 0;
	__Index		= 0;
	__Marks		= [];
	__Level		= -1;
	__State		= new Stack();
	
	__Type__.add( Parser );
	
}
