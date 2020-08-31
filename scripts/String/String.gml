/// @func String
/// @param string
/// @desc	Provides a wrapper for basic strings.
function String() constructor {
	static formatter	= function( _value ) {
		return string( _value );
		
	}
	static set	= function( _value ) {
		value	= formatter( _value );
		length	= string_length( _value );
		
	}
	static draw	= function( _x, _y, _font, _color ) {
		var _ofont	= draw_get_font();
		var _ocolor	= draw_get_color();
		
		draw_set_font( _font );
		draw_set_color( _color );
		
		draw_text( _x, _y, value );
		
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
		var _ofont	= draw_get_font();
		var _width;
		
		draw_set_font( _font );
		
		_width	= string_width( value );
		
		draw_set_font( _ofont );
		
		return _width;
		
	}
	static height	= function( _font ) {
		var _ofont	= draw_get_font();
		var _height;
		
		draw_set_font( _font );
		
		_height	= string_height( value );
		
		draw_set_font( _ofont );
		
		return _height;
		
	}
	static toArray	= function() {
		var _array	= array_create( length );
		
		var _i = 0; repeat( length ) {
			_array[ _i ]	= string_char_at( value, _i );
			
			++_i;
			
		}
		
	}
	static toString	= function() {
		return value;
		
	}
	value	= "";
	length	= 0;
	
	if ( argument_count > 0 ) {
		set( argument[ 0 ] );
		
	}
	
}
