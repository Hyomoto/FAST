/// @func Parser
/// @desc	The parser is used to break apart strings based on character runs.  By default, it will
///		uses spaces and tabs to break apart strings, but this can be changed by using the divider
///		method.
/// @example
//var _parser = new Parser().parse( "Hello.World!" )
//
//_parser.divider(".");
//
//_parser.next();
/// @output "Hello"
/// @wiki Core-Index Parsing
function Parser() : __Struct__() constructor {
	/// @param {string} string	The string to parse
	/// @desc	Sets string as the target for parsing.
	/// @throws InvalidArgumentType
	/// @returns self
	static parse	= function( _string ) {
		if ( is_string( _string ) == false ) { throw new InvalidArgumentType( "parse", 0, _string, "string" ); }
		
		__Content	= string_trim( _string );
		restart();
		
		return self;
		
	}
	/// @desc	Clears the contents of the parser.
	/// @returns self
	static clear	= function() {
		__Last		= 0;
		__Content	= "";
		
		return self;
		
	}
	/// @desc	Sets the parse position back to the start of the string.
	/// @returns self;
	static restart	= function() {
		__Last	= 0;
		
		return self;
		
	}
	/// @desc	Returns true if there is unparsed string remaining.
	/// @returns bool
	static has_next	= function() {
		return __Last < size();
		
	}
	/// @desc	Returns the next chunk in the string based on the divider.  If the end of the string
	///		has been reached, EOS is returned instead.
	/// @returns string or EOS
	static next		= function() {
		if ( has_next() == false )
			return EOS;
		
		var _string = ""; while ( _string == "" ) {
			var _next	= string_find_first( __Divider, __Content, __Last );
			
			if ( _next == 0 ) {
				_string	= string_trim( string_delete( __Content, 1, __Last - 1 ), __Divider );
				
				__Last	= size();
				
				break;
				
			}
			_string	= string_trim( string_copy( __Content, __Last, _next - max( 1, __Last ) ), __Divider );
			
			__Last	= _next + 1;
			
		}
		return _string;
		
	}
	/// @desc	Returns the remaining unparsed string, or EOS if the end of the string has been reached.
	/// @returns string or EOS
	static remaining	= function() {
		if ( has_next() == false )
			return EOS;
		
		var _string	= string_delete( __Content, 1, __Last - 1 );
		
		__Last	= size();
		
		return _string;
		
	}
	/// @desc	Reads and returns the next word in the parser without advancing it.  If the end of the
	///		param string has been reached, EOS is returned.
	/// @returns string or EOS
	static peek	= function() {
		if ( has_next() == false )
			return EOS;
		
		var _last	= __Last;
		var _string	= next();
		
		__Last	= _last;
		
		return _string;
		
	}
	/// @param {struct}	data	The saved state to return to.
	/// @desc	Returns the parser to a saved state.  If the struct provided is not a valid state,
	///		InvalidArgumentType will be thrown.
	/// @throws InvalidArgumentType
	/// @returns self
	static load	= function( _data ) {
		try {
			__Last		= _data.i;
			__Content	= _data.c;
			
		} catch ( _ ) {
			throw new InvalidArgumentType( "load", 0, _data, "state struct" );
			
		}
		return self;
		
	}
	/// @desc	Returns a struct with the state of the parser preserved.
	/// @returns struct
	static save	= function() {
		return { i: __Last, c: __Content }
		
	}
	/// @desc	Breaks up the string into an array and returns it.
	/// @returns array
	static to_array	= function() {
		var _last	= __Last;
		var _size	= 0;
		
		__Last	= 0;
		
		while ( has_next() ) { ++_size; next(); }
		
		var _array	= array_create( _size );
		
		__Last	= 0;
		
		var _i = 0; repeat( array_length( _array ) ) {
			_array[ _i++ ]	= next();
			
		}
		__Last	= _last;
		
		return _array;
		
	}
	/// @desc Returns the length of the internal string.
	/// @returns int
	static size	= function() {
		return string_length( __Content );
		
	}
	/// @param {bool}	remaining?	optional: Whether to only return the remainder
	/// @desc	Returns the string being parsed.  If remaining? is true, only the part of the string
	///		which has yet to be parsed will be returned.
	/// @returns string
	static toString	= function( _remaining ) {
		if ( _remaining == true ) {
			return string_delete( __Content, 1, __Last - 1 );
			
		}
		return __Content;
		
	}
	/// @var {struct}	A marker that is returned when the end of the string has been reached.
	/// @output constant
	static EOS	= {}
	/// @var {string}	The string being parsed.
	__Content	= "";
	/// @var {string}	The character string used to find the next breakpoint.
	/// @output " \t" (whitespace)
	__Divider	= " \t";
	/// @var {int}		The last position read from.
	__Last	= 0;
	
	__Type__.add( Parser );
	
}
