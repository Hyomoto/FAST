/// @param {real} _x
/// @param {real} _y
/// @param {string,function} _text
function UIText( _x, _y, _text, _kwargs = {} ) : UIElement() constructor {
	static draw	= function( _x = 0, _y = 0 ) {
		var _text	= is_method( text ) ? text() : text;
		var _f		= draw_get_font();
		var _c		= draw_get_color();
		var _h		= draw_get_halign();
		var _v		= draw_get_valign();
		
		draw_set_font( font ?? _f );
		draw_set_color( color ?? _c );
		draw_set_halign( halign ?? _h );
		draw_set_valign( valign ?? _v );
		
		if ( beforeDraw != undefined ) method_call( beforeDraw[ 0 ], beforeDraw, 1 );
		if ( is_defined( width )) draw_text_ext( x + _x, y + _y, _text, string_height( "A" ), width );
		else					  draw_text( x + _x, y + _y, _text );
		if ( afterDraw != undefined ) method_call( afterDraw[ 0 ], afterDraw, 1 );
		
		draw_set_font( _f );
		draw_set_color( _c );
		draw_set_halign( _h );
		draw_set_valign( _v );
		
	}
	static style	= function( _font = undefined, _color = undefined, _width = undefined, _halign = undefined, _valign = undefined ) {
		font	= _font;
		color	= _color;
		width	= _width;
		halign	= _halign;
		valign	= _valign;
		
		return self;
		
	}
	x		= _x;
	y		= _y;
	text	= string( _text );
	font	= _kwargs[$ "font" ];
	color	= _kwargs[$ "color" ];
	width	= _kwargs[$ "width" ];
	halign	= _kwargs[$ "halign" ];
	valign	= _kwargs[$ "valign" ];
	
}
