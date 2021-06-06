/// @ func StringFormatter
/// @desc	Used to store a set of rules than can then be applied to strings to return a formatted
///		result.  For example, if you wanted to remove all the white space from a given string, or
///		convert it to lower case letters.  While GML does have built-in functions for this,
///		StringFormatter can apply multiple rules to a string.  It is generally designed for
///		working with external files to produce a format that is easier for someone writing a
///		parser.
/// @example
//var _formatter = new StringFormatter();
//
//_formatter.set_rule( "\t ", "remove" );
//
//var _string = _formatter.format( "Hel	lo	W o r ld!" );
//
//show_debug_message( _string );
/// @output HelloWorld! is written to the output console.
/**
 * @todo Write ATS test cast for StringFormatter
 * @body As the title implies
 */
function StringFormatter() constructor {
	/// @param {String}	string	A string to format
	/// @desc	Formats the given string and returns it.
	/// @returns String
	static format	= function( _string ) {
		if ( not is_string( _string ) ) { return; }
		
		__String	= _string;
		__Ignore	= false;
		__Read		= 1;
		
		repeat( string_length( _string ) ) {
			var _rule	= __Rules[$ string_char_at( __String, __Read ) ];
			
			if ( _rule == undefined ) { advance(); continue }
			
			_rule( __Read );
			
		}
		return __String;
		
	}
	/// @param {String}	chars	A string containing the characters you would like to apply the rule to
	/// @param {Mixed}	func	Either a string, the name of the rule to apply, or a function to apply
	/// @desc	Each character in the string will have the provided rule applied to it. There are a number
	///		of pre-made rules that can be applied: advance, remove, safe, unsafe, safexor.  Otherwise, 
	///		the provided function will be bound to the character.  If a string is provided, but the rule
	///		does not exist, ValueNotFound is thrown.  Otherwise InvalidArgumentType will be thrown if
	///		a method was not provided.
	/// @throws ValueNotFound, InvalidArgumentType
	static set_rule		= function( _char, _f ) {
		static __allowedRules	= { advance: advance, remove: remove, safe: safe, unsafe: unsafe, safexor: safexor };
		
		var _rule	= is_string( _rule ) ? __allowedRules[$ _f ] : _rule;
		
		if ( is_undefined( _rule ) ) { throw new ValueNotFound( "set_rule", _f, -1 ); }
		if ( is_method( _rule ) == false ) { throw new InvalidArgumentType( "set_rule", 1, _f, "method" ); }
		
		_rule	= method( self, _rule );
		
		var _i = 1; repeat( string_length( _char ) ) {
			__Rules[$ string_char_at( _char, _i++ ) ]	= _rule;
			
		}
		
	}
	/// @desc	Returns the last formatted string.
	/// @returns String
	static toString	= function() {
		return __String;
		
	}
	/// @desc	Removes the last character read from the string
	static remove	= function() {
		if ( __Ignore ) { advance(); return; }
		
		__String	= string_delete( __String, __Read, 1 );
		
	}
	/// @param	{String}	string	The string to insert
	/// @insert	Inserts the given string at the last position read from
	static insert	= function( _v ) {
		if ( __Ignore ) { advance(); return; }
		
		__String	= string_insert( _v, __String, __Read );
		
		advance();
		
	}
	/// @param	{String}	string	The string to insert
	/// @insert	Replaces the last character read from with the given string
	static replace	= function( _v ) {
		if ( __Ignore ) { advance(); return; }
		
		__String	= string_copy( __String, 1, __Read - 1 ) + _v + string_delete( __String, 1, __Read );
		
	}
	/// @desc	Advances the read position. Can be used to skip a character, or to find a position
	///		to insert at.
	static advance	= function() {
		++__Read;
		
	}
	/// @desc	Toggles the ignore state. When ignoring, remove, insert and replace do not work.  Can
	///		be used to preserve text between quotation marks, for example.
	static safexor	= function() {
		if ( __Ignore ) { unsafe(); } else { safe(); }
		
	}
	/// @desc	Toggles the ignore state to true. When ignoring, remove, insert and replace do not work.
	static safe	= function() {
		__Ignore	= true;
		
	}
	/// @desc	Toggles the ignore state to false. When ignoring, remove, insert and replace do not work.
	static unsafe	= function() {
		__Ignore	= false;
		
	}
	/// @desc The internal rules map
	__Rules		= {};
	/// @desc The string being formatted/the last string formatted
	__String	= "";
	/// @desc When true, remove, insert and replace do not work.
	__Ignore	= false;
	/// @desc 
	__Read		= 0;
	
}
