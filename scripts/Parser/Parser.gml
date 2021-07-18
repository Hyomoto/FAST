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
		// if a stream is provided, convert to __Stream__
		if ( struct_type( _string, __Stream__ ))
			_string	= new __Stream__( _string ).open();
		// if an input stream is provided, set up streaming
		if ( struct_type( _string, __InputStream__ )) {
			__Content	= "";
			__Stream	= _string;
			__Index		= 0;
			__Level		= -1;
			__Size		= 0;
			__Buffer	= undefined;
			return;
		}
		// otherwise handle as string
		if ( _string != undefined ) {
			if ( is_string( _string ) == false )
				throw new InvalidArgumentType( "open", 0, _string, "string" );
			__Stream	= undefined;
			__Content	= _string;
			__Size		= string_length( _string );
			__Index		= 0;
			__Level		= -1;
			__Buffer	= undefined;
		}
		return self;
		
	}
	static close	= function() { return self; }
	static clear	= function() {
		__Content	= "";
		__Size		= 0;
		__Index		= 0;
		__Level		= -1;
		__State.clear();
	}
	static finished	= function() {
		if ( __Stream == undefined )
			return __Index == __Size;
		return __Index == __Size && __Stream.finished();
		
	}
	/// @param {method}	char_func	A char_ function or equivalent method
	/// @param {bool}	*is_true	optional: If false, will invert the comparison
	/// @desc	Reads the next 'word' in the string based on the character function.
	static word	= function( _f, _ws ) {
		if ( _ws != false ) { _ws = true; }
		if ( _f == undefined ) { _f = char_is_whitespace; }
		
		skip( _f, !_ws );
		
		if ( finished() )
			return "";
		
		read( _f, _ws );
		
		return __Buffer;
		
	}
	static remaining	= function() {
		__Buffer	= string_copy( __Content, __Index + 1, __Size - __Index );
		__Index		= __Size;
		
		return __Buffer;
		
	}
	/// @param {method}	char_func	A char_ function or equivalent method
	/// @param {bool}	*is_true	optional: If false, will invert the comparison
	/// @desc	Advances the read position in the string as if the character function returns true,
	///		unless is_true is false.
	static skip	= function( _c, _ws ) {
		if ( _ws != false ) { _ws = true; }
		
		mark();
		var _i = 0; while( finished() == false ) {
			if ( _c( read()) != _ws )
				break;
			++_i;
		}
		reset();
		
		advance( _i );
		
	}
	/// @desc	Advances the read position in the string.
	static advance	= function( _c ) {
		__Index	= min( __Size, __Index + _c );
		
		return self;
		
	}
	/// @desc	Returns the next character in the string.
	/// @returns char
	static read	= function( _f, _ws ) {
		// if string has ended, but stream has not
	    if ( __Stream != undefined && __Index == __Size ) {
			var _read	= __Stream.read();
			
			__Content	+= _read;
			__Size		= string_length( __Content );
			
		}
		if ( finished() )
			return END;
		
		if ( _f == undefined ) {
			__Buffer	= string_char_at( __Content, ++__Index );
			
		} else if ( is_real( _f ) && _f < 100000 ) {
			var _i = min( __Size - __Index, _f );
			
			__Buffer	= string_copy( __Content, __Index + 1, _i );
			
			advance( _i );
			
		} else {
			if ( _ws != false ) { _ws = true; }
			
			mark();
			var _i = 0; while( finished() == false ) {
				if ( _f( string_char_at( __Content, ++__Index )) != _ws )
					break;
				++_i;
			}
			reset();
			
			__Buffer	= string_copy( __Content, __Index + 1, _i );
			
			advance( _i );
			
		}
		return __Buffer;
		
	}
	/// @param {int}	*num	optional: Number of characters to peek
	/// @desc	Returns the next character in the string without advancing the index.
	/// @returns char
	static peek	= function( _num ) {
		if ( _num == undefined ) { _num = 1; }
		if ( __Index + 1 + _num > __Size ) { _num = __Size - __Index; }
		
		return string_copy( __Content, __Index + 1, _num );
		
	}
	/// @desc	Remembers the last read position.
	static mark	= function() {
		__Marks[ ++__Level ] = __Index;
		
		return self;
		
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
		if ( __Level < 0 )
			__Index = 0;
		else
			__Index = unmark();
		
		return self;
		
	}
	/// @desc	Reverses the last read.
	static unread	= function() {
		if ( __Index == 0 )
			throw new IndexOutOfBounds( "unread", __Index, "Can not unread from beginning of string.");
		--__Index;
		
		return self;
		
	}
	/// @desc	Returns the parser to a state previously pushed onto the save stack.
	/// @returns self
	static pop	= function( _data ) {
		if ( __State.size() == 0 )
			throw new __Error__().from_string( "No state saved to parser to load!" );
		__Content	= __State.peek().c;
		__Index		= __State.peek().i;
		__Size		= string_length( __Content );
		
		__State.pop();
		
		return self;
		
	}
	/// @desc	Saves the current state of the parser to a stack. Can be returned to with load().
	/// @returns struct
	static push	= function() {
		__State.push({ i: __Index, c: __Content });
		
		return self;
		
	}
	static count	= function( _c, _ws ) {
		if ( _ws != false ) { _ws = true; }
		
		mark();
		var _i = 0; while( finished() == false ) {
			word( _c, _ws ); ++_i;
			
		}
		reset();
		
		return _i;
		
	}
	static to_array	= function( _c, _ws ) {
		if ( _c == undefined ) { _c = char_is_whitespace; }
		if ( _ws == undefined ) { _ws = false; }
		
		push();
		reset();
		
		var _array	= array_create( count( _c, _ws ));
		var _i = 0; repeat( array_length( _array )) {
			_array[ _i++ ]	= word( _c, _ws );
			
		}
		pop();
		
		return _array;
		
	}
	static toString	= function() {
		return __Content;
		
	}
	static END	= {}
	
	__Content	= "";
	__Stream	= undefined;
	__Size		= 0;
	__Index		= 0;
	__Marks		= [];
	__Level		= -1;
	__State		= new Stack();
	
	__Type__.add( Parser );
	
}
