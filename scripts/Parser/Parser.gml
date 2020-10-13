/// @func Parser
/// @desc Will break up strings based on white space, and allow them to be read from much like you
// would a text file. You can check if there is more to read, or request the new word in the string. Also
// serves as an interface for building use-case specific parsers such as the (#ScriptParser).
/// @example
//var _parser = new Parser().parse( "Hello World!" )
//
//while( _parser.has_next() ) {
//	show_debug_message( _parser.next() );
//}
/// @wiki Core-Index Parsing
function Parser() constructor {
	/// @desc Returns the length of the internal string
	/// @returns intp
	static size	= function() {
		return string_length( content );
		
	}
	/// @desc Readies a string for parsing
	/// @param {string} string The string to parse
	/// @returns self
	static parse	= function( _string ) {
		content	= string_trim( _string );
		reset();
		
		return self;
		
	}
	/// @desc Clears the parser of input
	static clear	= function() {
		last	= 0;
		content	= "";
		
	}
	/// @desc Resets the parser to start at the beginning of the string
	static reset	= function() {
		last	= 0;
		
	}
	/// @desc Returns `true` if there is string remaining to be parsed.
	/// @returns string
	static has_next	= function() {
		return ( last < size() );
		
	}
	/// @desc Returns the next word in the string, or `undefined` if there is nothing left to parse.
	/// @returns string||null
	static next		= function() {
		if ( has_next() == false ) {
			return undefined;
			
		}
		var _string;
		
		do {
			var _peek	= peek();
			
			_string	= _peek[ 0 ];
			last	= _peek[ 1 ];
			
		} until ( _string != "" );
		
		return _string;
		
	}
	/// @desc Returns the rest of the unparsed string, or `undefined` if nothing is left.
	/// @returns string || null
	static next_line	= function() {
		if ( has_next() == false ) {
			return undefined;
			
		}
		var _string	= string_copy( content, last, size() - last + 1 );
		
		last	= size();
		
		return _string;
		
	}
	/// @desc Returns the next word in the string without advancing the parser.
	static peek	= function() {
		var _next	= string_find_first( " \t", content, last );
		
		if ( _next == 0 ) {
			return [ string_trim( string_copy( content, last, size() - last + 1 ) ), size() ];
			
		}
		return [ string_trim( string_copy( content, last, _next - last ) ), _next + 1 ];
		
	}
	/// @desc Returns the internal string broken up into words as an array.
	static toArray	= function() {
		var _queue	= new DsQueue();
		var _last	= last;
		
		last	= 0;
		
		while ( has_next() ) {
			_queue.enqueue( next() );
			
		}
		var _array	= array_create( _queue.size() );
		
		var _i = 0; repeat( array_length( _array ) ) {
			_array[ _i++ ]	= _queue.dequeue();
			
		}
		last	= _last;
		
		return _array;
		
	}
	/// @desc Returns the internal string.
	static toString	= function() {
		return content;
		
	}
	static is		= function( _data_type ) {
		return _data_type == Parser;
		
	}
	/// @desc the internal string
	content	= "";
	/// @desc the last position read from
	last	= 0;
	
}
