/// @func Parser
/// @param *string
function Parser( _string ) constructor {
	static toString	= function() {
		return value;
		
	}
	static parse	= function( _string ) {
		value	= string_trim( _string );
		length	= string_length( value );
		last	= 0;
		
	}
	static clear	= function() {
		last	= 0;
		length	= 0;
		value	= "";
		
	}
	static reset	= function() {
		last	= 0;
		
	}
	static has_next	= function() {
		return ( last < length );
		
	}
	static remaining	= function() {
		if ( has_next() == false ) {
			return undefined;
			
		}
		var _string	= string_copy( value, last, length - last + 1 );
		
		last	= length;
		
		return _string;
		
	}
	static next		= function() {
		if ( has_next() == false ) {
			return undefined;
			
		}
		var _string;
		
		static seek	= function() {
			var _next	= string_find_first( " \t", value, last );
			var _string;
			
			if ( _next == 0 ) {
				_string	= string_copy( value, last, length - last + 1 );
				
				last	= length;
				
			} else {
				_string	= string_copy( value, last, _next - last );
				
				last	= _next + 1;
				
			}
			return string_trim( _string );
			
		}
		do {
			_string	= seek();
			
		} until ( _string != "" );
		
		return _string;
		
	}
	value	= "";
	length	= 0;
	last	= 0;
	
	if ( _string != undefined && _string != "" ) {
		reset();
		parse( _string );
		
	}
	
}
