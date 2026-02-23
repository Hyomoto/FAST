function Scanner( _string = undefined ) constructor {
	/// @desc Returns true if the character is a lower case letter.
	static isLower	= function() { return ( peek() >= "a" && peek() <= "z" ); }
	/// @desc Returns true if the character is a upper case letter.
	static isUpper	= function() { return ( peek() >= "A" && peek() <= "Z" ); }
	/// @desc Returns true if the character is a letter.
	static isAlpha	= function() { return isLower() || isUpper(); }
	/// @desc Returns true if the character is a number.
	static isDigit	= function() { return ( peek() >= "0" && peek() <= "9" ); }
	/// @desc Returns true if the character is a letter, number or punctuation.
	static isGraph	= function() { return isAlpha() || isDigit() || isPunct(); }
	/// @desc Returns true if the character is a letter or number.
	static isAlnum	= function() { return isAlpha() || isDigit(); }
	/// @desc Returns true if the character is punctuation.
	static isPunct	= function() { return string_pos( peek(), "!\"#$%&'()*+,-./:;?@[\\]^_`{|}~" ) > 0; }
	/// @desc Returns true if the character is a whitespace character.
	static isSpace	= function() { return peek() == " " || ( peek() <= "\r" && peek() >= "\t" ); }
	/// @desc Returns true if the character is a control code.
	static isCntrl	= function() { return ord( peek() ) <= 0x1f || ord(peek() ) == 0x7f; }
	/// @desc Returns true if the character is a hexadecimal value.
	static isXDigit	= function() { return string_pos( peek(), "0123456789abdefABCDEF" ) > 0; }
	/// @desc Returns if the provided character matches the given class.
	/// @param {string} _class	A class: acdglpsuwx. Use a capital letter to invert the comparison. d is any number, D is any non-number.
	static isClass	= function( _class ) {
		var _neg = string_upper( _class ) == _class;
		
		switch( string_lower( _class )) {
			case "a" : return isAlpha() ^ _neg;
			case "c" : return isCntrl() ^ _neg;
			case "d" : return isDigit() ^ _neg;
			case "g" : return isGraph() ^ _neg;
			case "l" : return isLower() ^ _neg;
			case "p" : return isPunct() ^ _neg;
			case "s" : return isSpace() ^ _neg;
			case "u" : return isUpper() ^ _neg;
			case "w" : return isAlnum() ^ _neg;
			case "x" : return isXDigit()^ _neg;
			default : return false;
			
		}
		
	}
	/// @desc Placeholder function that currently does nothing.  For complex
	///		pattern matching.
	static crawl	= function( _class ) {
		
		
	}
	/// @param {string,real,function} _pattern Default: none. A number, single character, or a method.
	/// @desc Consumes the string by match and returns the result. When no
	///		pattern is given, the next character is matched. If a pattern is
	///		given as a real number, that number of characters are matched.
	///		Patterns can be specific classes (acdglpsuwx), quotes (q), brackets
	///		(b), numbers (n), or specific brackets <[{(. Any other character
	///		will attempt to match a pair, eg: " would seek a complimentary
	///		double-quote. If no match is found, an empty string is returned. If
	///		the pattern is given as '!' and a character, it will read until
	///		that character is found or the string ends.
	static read	= function( _pattern = undefined ) {
		if ( index > length )
			return "";
		if ( _pattern == undefined )
			return string_char_at( content, index++ );
		
		if ( is_real( _pattern )) {
			index	+= _pattern;
			return string_copy( content, index - _pattern, _pattern );
			
		}
		var _c	= 0;
		
		if ( is_method( _pattern )) {
			while( !isFinished() && _pattern( peek()) ) { ++_c; seek(); }
			return string_copy( content, index - _c, _c );
			
		} else if ( string_char_at( _pattern, 1 ) == "!" && string_length( _pattern ) == 2 ) {
			var _char	= string_char_at( _pattern, 2 );
			while( !isFinished() && peek() != _char ) { ++_c; seek(); }
			return string_copy( content, index - _c, _c );
			
		} else if ( string_pos( string_lower( _pattern ), "acdglpsuwx" )) {
			while( !isFinished() && isClass( _pattern ) ) { ++_c; seek(); }
			return string_copy( content, index - _c, _c );
			
		} else {
			var _open, _close, _greedy = true;
			
			push(); // save our starting point
			
			switch( _pattern ) {
				case "\n" :
					while( !isFinished() && peek() != "\n" ) { ++_c; seek(); }
					return string_copy( content, index - _c, _c );
					break;
					
				case "q":
					if ( match( "\"" )) { _open = "\""; _close = "\""; }
					else if ( match( "'" )) { _open = "'"; _close = "'"; }
					else return "";
					break;
					
				case "b":
					if ( match( "{" )) { _open = "{"; _close = "}"; }
					else if ( match( "(" )) { _open = "("; _close = ")"; }
					else if ( match( "[" )) { _open = "["; _close = "]"; }
					else if ( match( "<" )) { _open = "<"; _close = ">"; }
					else return "";
					_greedy = false;
					break;
					
				case "n":
					pop(); // throw away last pin
					
					var _neg	= match( "-" );
					var _num	= read( "d" );
					if ( match( "." ))
						_num += "." + read( "d" );
					return _neg ? "-" + _num : _num;
					
				case "{": _open = "{"; _close = "}"; _greedy = false; break;
				case "(": _open = "("; _close = ")"; _greedy = false; break;
				case "[": _open = "["; _close = "]"; _greedy = false; break;
				case "<": _open = "<"; _close = ">"; _greedy = false; break;
				default	: _open = _pattern; _close = _pattern; break;
				
			}
			pop(); // return to the start for matching
			
			if ( match( _open ) == false )
				return ""; // nothing matched
			
			push(); // push the read position again in case matching fails
			
			var _i	= 1;
			
			repeat( length - index + 1 ) {
				if ( match( _close )) {
					if ( --_i == 0 ) {
						pop( false ); // pop the last pin, don't seek
						return string_copy( content, index - _c - 1, _c );
						
					}
					
				} else if ( !_greedy && match( _open ))
					_i += 1;
				
				seek(); ++_c;
				
			}
			pop();
			--index; // revert the read position, no match
			
			return "";
			
		}
		
	}
	/// @desc Advances the current read position.
	static seek		= function( _ahead = 1 ) {
		index += _ahead;
		return self;
		
	}
	/// @desc Returns the next character without consuming it.
	static peek		= function( _ahead = 0 ) {
		if ( index + _ahead > length )
			return undefined;
		return string_char_at( content, index + _ahead );
		
	}
	/// @desc Advances the index without returning the result.
	static skip	= function( _class ) {
		if ( _class == "\n" ) {	while( !isFinished() && peek() != "\n" ) { ++index; } ++index; }
		else					while( !isFinished() && isClass( _class )) { ++index; }
		return self;
		
	}
	/// @param {string} _pattern A string to match.
	/// @desc Returns whether the next segment of the string matches the
	///		given pattern.  If true, it will also advance the scanner.
	static match	= function( _pattern ) {
		if ( string_copy( content, index, string_length( _pattern )) != _pattern )
			return false;
		index	+= string_length( _pattern );
		return true;
		
	}
	/// @desc Pushes the current read position to pins.
	static push	= function() {
		array_push( pins, index );
		return self;
		
	}
	/// @desc Pops the last pinned position.  If seek is false, the read position will not be changed.
	static pop	= function( _seek = true ) {
		if ( _seek )	index = array_pop( pins );
		else			array_pop( pins );
		return self;
		
	}
	/// @param {string} _string
	/// @desc Prepare the scanner with a new string.
	static open	= function( _string ) {
		content	= _string;
		index		= 1;
		length	= string_length( _string );
		pins	= [];
		
		return self;
		
	}
	/// @desc Returns the section of string between the two points, inclusive.
	static copy	= function( _start = index, _end = length ) {
		return string_copy( content, _start, _end - _start + 1 );
		
	}
	/// @desc Returns if scanning has reached the end of the string.
	static isFinished	= function() {
		return index > length;
		
	}
	content	= undefined;
	index	= 0;
	length	= 0;
	pins	= [];
	
	if ( is_string( _string ))
		open( _string );
	
}
