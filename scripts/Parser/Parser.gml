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
function Parser( _divider ) constructor {
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
		if ( has_next() == false ) { return undefined; }
		
		var _string = ""; while ( _string == "" ) {
			var _next	= string_find_first( divider, content, last );
			
			if ( _next == 0 ) {
				_string	= string_trim( string_delete( content, 1, last - 1 ), divider );
				
				last	= size();
				
				break;
				
			}
			_string	= string_trim( string_copy( content, last, _next - max( 1, last ) ), divider );
			
			last	= _next + 1;
			
		}
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
		var _last	= last;
		var _string	= next();
		
		last	= _last;
		
		return _string;
		
	}
	static load	= function( _data ) {
		last	= _data.i;
		content	= _data.c;
		
	}
	static save	= function() {
		return { i: last, c: content }
		
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
	/// @param {bool} remaining? optional: if true, returns the unparsed remainder
	/// @desc Returns the internal string.
	static toString	= function( _remaining ) {
		if ( _remaining == true ) {
			return string_delete( content, 1, last );
			
		}
		return content;
		
	}
	static is		= function( _data_type ) {
		return _data_type == Parser;
		
	}
	/// @desc the internal string
	content	= ( argument_count > 0 ? argument[ 0 ] : "" );
	/// @desc The character string used to find the next breakpoint. Default: " \t" (whitespace)
	divider	= ( is_string( _divider ) ? _divider : " \t" );
	/// @desc the last position read from
	last	= 0;
	
}
