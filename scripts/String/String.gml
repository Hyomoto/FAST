/// @func String
/// @param {string} string Sets the initial contents of this String
/// @desc	Provides a wrapper for the basic string data type, as well as an interface for implementing extended String types.
/// @example
//var _string = new String( "Hello World!" );
/// @wiki Core-Index Strings
function String() constructor {
	/// @param {String}	string The string to set
	/// @desc	Sets the contents to the provided string.  If a string is not provided, InvalidArgumentType
	///		will be thrown.
	/// @throws InvalidArgumentType
	/// @returns self
	static set	= function( _string ) {
		if ( is_string( _string ) == false ) { throw new InvalidArgumentType( "set", 0, _string, "string" ) }
		
		__String	= _string;
		
		return self;
		
	}
	/// @param {String}	substr	The string to look for
	/// @param {String} newstr	The string to replace with
	/// @param {bool}	*all	optional: If true, all occurances will be replaced
	///	@desc	Replaces the first occurance of substr with newstr.  If all is true, all
	///		occurances will be replaced instead.  If substr or newstr are not strings
	///		then InvalidArgumentType will be thrown.
	/// @throws InvalidArgumentType
	static replace	= function( _substr, _newstr, _all ) {
		if ( is_string( _substr ) == false ) { throw new InvalidArgumentType( "replace", 0, _substr, "string" ) }
		if ( is_string( _newstr ) == false ) { throw new InvalidArgumentType( "replace", 1, _newstr, "string" ) }
		
		if ( _all == true ) {
			__Content	= string_replace_all( __Content, _substr, _newstr );
			
		} else {
			__Content	= string_replace( __Content, _substr, _newstr );
			
		}
		
	}
	/// @desc returns the number of characters in the String
	static length	= function() {
		return string_length( __String );
		
	}
	static draw	= function( _x, _y, _font, _color ) {
		var _ofont	= draw_get_font();
		var _ocolor	= draw_get_color();
		
		if ( _font != undefined ) {
			draw_set_font( _font );
		}
		if ( _color != undefined ) {
			draw_set_color( _color );
		}
		draw_text( _x, _y, __String );
		
		draw_set_font( _ofont );
		draw_set_color( _ocolor );
		
	}
	static draw_ext	= function( _x, _y, _font, _color, _halign, _valign ) {
		var _ohalign	= draw_get_halign();
		var _ovalign	= draw_get_valign();
		
		draw_set_halign( _halign );
		draw_set_valign( _valign );
		
		draw( _x, _y, _font, _color );
		
		draw_set_halign( _ohalign );
		draw_set_valign( _ovalign );
		
	}
	static width	= function( _font ) {
		if ( _font == undefined ) {
			return string_width( __String );
			
		}
		var _ofont	= draw_get_font();
		var _width;
		
		draw_set_font( _font );
		
		_width	= string_width( __String );
		
		draw_set_font( _ofont );
		
		return _width;
		
	}
	static height	= function( _font ) {
		if ( _font == undefined ) {
			return string_width( __String );
			
		}
		var _ofont	= draw_get_font();
		var _height;
		
		draw_set_font( _font );
		
		_height	= string_height( __String );
		
		draw_set_font( _ofont );
		
		return _height;
		
	}
	static to_array	= function() {
		var _array	= array_create( length() );
		
		var _i = 0; repeat( array_length( _array ) ) {
			_array[ _i ]	= string_char_at( __String, _i );
			
			++_i;
			
		}
		return _array;
		
	}
	static toString	= function() {
		return __String;
		
	}
	__String	= "";
	
}
