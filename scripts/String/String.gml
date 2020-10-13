/// @func String
/// @param {string} string Sets the initial contents of this String
/// @desc	Provides a wrapper for the basic string data type, as well as an interface for implementing extended String types.
/// @example
//var _string = new String( "Hello World!" );
/// @wiki Core-Index Strings
function String() constructor {
	/// @desc returns the number of characters in the String
	static size	= function() {
		return string_length( _content );
		
	}
	/// @param {string} string Sets the contents of this String
	static set	= function( _content ) {
		content	= _content;
		
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
		draw_text( _x, _y, content );
		
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
			return string_width( content );
			
		}
		var _ofont	= draw_get_font();
		var _width;
		
		draw_set_font( _font );
		
		_width	= string_width( content );
		
		draw_set_font( _ofont );
		
		return _width;
		
	}
	static height	= function( _font ) {
		if ( _font == undefined ) {
			return string_width( content );
			
		}
		var _ofont	= draw_get_font();
		var _height;
		
		draw_set_font( _font );
		
		_height	= string_height( content );
		
		draw_set_font( _ofont );
		
		return _height;
		
	}
	static is		= function( _data_type ) {
		return _data_type == String;
		
	}
	static toArray	= function() {
		var _array	= array_create( size() );
		
		var _i = 0; repeat( array_length( _array ) ) {
			_array[ _i ]	= string_char_at( content, _i );
			
			++_i;
			
		}
		return _array;
		
	}
	static toString	= function() {
		return content;
		
	}
	content	= "";
	
	if ( argument_count > 0 ) {
		set( argument[ 0 ] );
		
	}
	
}
