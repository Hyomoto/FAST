/// @description The interface element is an abstract constructor to represent the common interface
///     that all Interface constructors share.
function InterfaceElement() constructor {
    static draw = function( _x, _y, _time = 0 ) {}
    static getWidth = function() { return 0; }
    static getHeight = function() { return 0; }
    static style = function( _style ) {}
    static style_ = function( _style, _kwargs ) {
        array_foreach(_kwargs, method({ "this" : self, "kwargs" : _style }, function( k ) {
            this[$ k] = struct_get(kwargs, k) ?? this[$ k ]
            
        }));
        
    }
    before = undefined;
    after = undefined;
    
}
/// @param {asset.GMSprite} _sprite The sprite to be drawn
/// @param {struct} _style A list of style arguments to apply.
function InterfaceSprite( _sprite, _style = undefined) : InterfaceElement() constructor {
    /// @param {struct} _style A struct of keyword arguments.
    /// @desc A constructor for a sprite interface element.
    /// * animate [bool] - whether or not to animate this sprite
    /// * frame [float] - the frame to show (or start the animation)
    /// * tint [int] - a color code to tint the sprite with
    /// * alpha [float] - the alpha value to draw the sprite
    /// * rotate [int] - the rotation of the sprite
    /// * clip [array[x1,y1,x2,y2]] - sets the sprite to clip the specified dimensions
    /// * stretch [array[w, h]] - stretches the sprite to the given dimensions
    /// * scale [array[w, h]] - scales the sprite by the given dimensions
    static style = function( _style ) {
        static MODES = {"clip" : draw_part_, "stretch" : draw_stretch_, "scale" : draw_scale_}
        style_( _style, ["animate", "frame", "tint", "alpha", "rotate"]);
        for ( var _i = 0, _n = struct_get_names(MODES); _i < array_length( _n ); ++_i ) {
            var _key = _n[ _i ];
            if not is_undefined( _style[$ _key ] ) {
                draw = MODES[$ _key ]
                box = _style[$ _key ]
                return self;
            }
        }
        return self;
        
    }
    /// @desc Draw the text to the given coordinates.
    /// @param {real} _x The x position to draw at
    /// @param {real} _y The y position to draw at
    /// @param {real} [_time] If specified, and text is a function, is passed to the text to affect output.
    static draw_ = function( _x, _y, _time = 0 ) {
        if ( sprite == -1 )
            return;
        var _index	= animate ? start_frame + _time / 1_000_000 * sprite_get_speed( sprite ) : start_frame;
        draw_sprite_ext( sprite, _index, _x, _y, 1, 1, rotation, tint, alpha );
    }
    static draw_scale_ = function( _x, _y, _time = 0 ) {
        if ( sprite == -1 )
            return;
        var _index	= animate ? start_frame + _time / 1_000_000 * sprite_get_speed( sprite ) : start_frame;
        draw_sprite_ext( sprite, _index, _x, _y, box[0], box[1], rotation, tint, alpha );
    }
    static draw_stretch_ = function( _x, _y, _time = 0 ) {
        if ( sprite == -1 )
            return;
        var _index	= animate ? start_frame + _time / 1_000_000 * sprite_get_speed( sprite ) : start_frame;
        draw_sprite_stretched_ext( sprite, _index, _x, _y, box[0], box[1], tint, alpha );
    }
    static draw_part_ = function( _x, _y, _time = 0 ) {
        if ( sprite == -1 )
            return;
        var _index	= animate ? start_frame + _time / 1_000_000 * sprite_get_speed( sprite ) : start_frame;
        draw_sprite_part( sprite, _index, box[0], box[1], box[2], box[3], _x, _y);
    }
    static getWidth = function() {
        if ( draw == draw_ )        return sprite_get_width( sprite );
        if ( draw == draw_scale_ )  return sprite_get_width( sprite ) * box[0];
        if ( draw == draw_stretch_) return box[0];
        if ( draw == draw_part_)    return box[2];
        throw "InterfaceSprite.getWidth failed because draw was an invalid method."
    }
    static getWidth = function() {
        if ( draw == draw_ )        return sprite_get_height( sprite );
        if ( draw == draw_scale_ )  return sprite_get_height( sprite ) * box[1];
        if ( draw == draw_stretch_) return box[1];
        if ( draw == draw_part_)    return box[3];
        throw "InterfaceSprite.getHeight failed because draw was an invalid method."
    }
    draw = draw_;
    sprite = _sprite;
    animate = true;
    start_frame = 0;
    tint = c_white;
    alpha = 1.0;
    stretch = undefined;
    rotation = 0;
    box = undefined;
    
    if not is_undefined( _style ) style( _style );
    
}
/// @param {string,function} _text A string or method that returns a string to draw.
/// @param {struct} _style A list of style arguments to apply.
function InterfaceText( _text, _style = undefined ) : InterfaceElement() constructor {
    /// @param {struct} _style A struct of keyword arguments.
    /// @desc A constructor for a text interface element.
    /// * valign [fa_] - The valignment to use
    /// * halign [fa_] - The halignment to use
    /// * font [GMfont] - The font to use
    /// * color [int] - A color value to tint the text with
    /// * separation [real] - The width of the lines, by default is determined by the font
    /// * wrap [real] - When set, wraps the text at the given boundary
    static style = function( _style ) {
        style_( _style, [ "valign", "halign", "color", "font", "separation", "wrap"]);
        return self;
        
    }
    /// @desc Draw the text to the given coordinates.
    /// @param {real} _x The x position to draw at
    /// @param {real} _y The y position to draw at
    /// @param {real} [_time] If specified, and text is a function, is passed to the text to affect output.
    static draw = function( _x, _y, _time = 0 ) {
        var _text = is_method( text ) ? text(_time) : text;
        var _font = draw_get_font();
        var _color = draw_get_color();
        var _halign = draw_get_halign();
        var _valign = draw_get_valign();
        
        draw_set_font(font ?? _font);
        draw_set_halign(halign ?? _halign);
        draw_set_valign(valign ?? _valign);
        draw_set_color(color ?? _color);
        
        if is_undefined( wrap ) draw_text( _x, _y, _text );
        else                    draw_text_ext( _x, _y, _text, separation ?? string_height("A"), wrap );
        
        draw_set_font( _font );
		draw_set_color( _color );
		draw_set_halign( _halign );
		draw_set_valign( _valign );
		
    }
    static getWidth = function() {
        var _font = draw_get_font();
        draw_set_font( font ?? _font );
        var _w = is_undefined( wrap ) ? string_width( is_method( text ) ? text(0) : text ) : wrap;
        draw_set_font( _font );
        return _w;
        
    }
    static getHeight = function() {
        var _font = draw_get_font();
        draw_set_font( font ?? _font );
        var _h = is_undefined( wrap ) ? (separation ?? string_height("A")) : string_width_ext( is_method( text ) ? text(0) : text, separation ?? string_height("A"), wrap );
        draw_set_font( _font );
        return _h;
        
    }
    text = _text;
    halign = undefined;
    valign = undefined;
    font = undefined;
    color = undefined;
    separation = undefined;
    wrap = undefined;
    
    if not is_undefined( _style ) style( _style );
    
}
function InterfaceLayer( _width = undefined, _height = undefined ) : InterfaceElement() constructor {
    static draw	= function( _x, _y ) {
		_x	+= x;
		_y	+= y;
		
		if ( dirty ) {
			array_sort( byId, function( _a, _b ) { return _a.depth - _b.depth; });
			sorted	= array_filter( byId, function( _v ) { return _v.visible });
			array_map_ext( sorted, function( _v ) { return _v.thing; });
			dirty	= false;
			
		}
		var _i = 0; repeat( array_length( sorted )) {
			if ( is_array( sorted[ _i ] )) {
				var _l	= array_length( sorted[ _i ] );
				var _c	= array_create( _l + 2, 0 );
				array_copy( _c, 0, sorted[ _i ], 0, _l );
				_c[ _l ]	= _x;
				_c[ _l + 1 ]	= _y;
				
				method_call( _c[ 0 ], _c, 1 );
				
			}
			else sorted[ _i ].draw( _x, _y );
			++_i;
			
		}
		
	}
	static get	= function( _key ) {
        var _thing = byKey[$ _key ];
        if is_undefined( _thing )
            throw new Exception( $"Tried to get key '{_key}' but the element did not exist.")
		return byKey[$ _key ].thing;
		
	}
    static find_entry = function( _key_or_element ) {
        var _what = undefined;
        if is_string( _key_or_element ) {
            _what = byKey[$ _keyor_element ];
    		if is_undefined( _what )
    			throw new Exception( $"Tried to find '{_key_or_element}', but the element did not exist." ); 
        } else {
            var _i = 0; repeat( array_length( byId )) {
                if (byId[ _i++ ].thing == _key_or_element) {
                    _what = byId[_i - 1];
                    break;
                }
            }
        }
        return _what;
        
    }
    /// @desc Show the given element
    /// @param {string,struct} _key_or_element The element to show
	static show	= function( _key_or_element ) {
        var _what = find_entry( _key_or_element ); 
        dirty           = true;
        _what.visible   = true;
		return _what.thing;
		
	}
    /// @desc Show the given element
    /// @param {string,struct} _key_or_element The element to hide
    static hide = function( _key_or_element ) {
        var _what = find_entry( _key_or_element );
        dirty           = true;
		_what.visible   = true;
		return _what.thing;
        
	}
	/// @param {string} _name
	/// @param {real} _depth
	/// @param {Struct.UIElement,Id.Instance,function,array} _thing
	/// @param {bool} _visible
	static add	= function( _x, _y, _thing, _name = undefined, _depth = 0, _visible = true ) {
		if ( is_method( _thing ))
			_thing	= [ _thing ];
		
		var _new	= { "x" : _x, "y" : _y, "thing" : _thing, "depth" : _depth, "visible" : _visible };
		dirty	= true;
		
        if not is_undefined(_name)
		  byKey[$ _name ]	= _new;
		array_push( byId, _new );
		
		return _thing;
		
	}
	static remove	= function( _name_or_thing ) {
        var _item	= is_string( _name_or_thing ) ? byKey[$ _name_or_thing ] : _name_or_thing;
		byId	= array_filter( byId, method({"v" : _item }, function( _v ) {
			return _v != v;
			
		}));
        if is_string( _name_or_thing )
		  struct_remove( byKey, _name_or_thing );
		dirty	= true;
		
	}
	static size	= function() { return array_length( byId ); }
	width	= _width;
	height	= _height;
	byId	= [];
	byKey	= {};
	sorted	= [];
	dirty	= false;
	
}