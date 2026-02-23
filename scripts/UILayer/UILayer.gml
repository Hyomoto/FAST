function UILayer( _x = 0, _y = 0, _width = infinity, _height = infinity, _callback = undefined ) : UIInteraction( _callback ) constructor {
	static isInside	= function( _x, _y ) {
		return point_in_rectangle( _x - x, _y - y, 0, 0, w, h );
		
	}
	static draw	= function( _x, _y ) {
		_x	+= x;
		_y	+= y;
		
		if ( dirty ) {
			array_sort( byId, function( _a, _b ) {
				return _a.depth - _b.depth;
				
			});
			sorted	= array_filter( byId, function( _v ) { return _v.visible });
			array_map_ext( sorted, function( _v ) { return _v.thing; });
			dirty	= false;
			
		}
		if ( beforeDraw != undefined ) method_call( beforeDraw[ 0 ], beforeDraw, 1 );
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
		if ( afterDraw != undefined ) method_call( afterDraw[ 0 ], afterDraw, 1 );
		
		
	}
	static setVisible	= function( _what, _visible = true ) {
		if ( byKey[$ _what ] == undefined )
			throw new Exception( $"Tried to set {_what}, but no element exists." );
		byKey[$ _what ].visible	= _visible;
		dirty	= true;
		return byKey[$ _what ];
		
	}
	static setActive	= function( _what, _active = true ) {
		if ( byKey[$ _what ] == undefined )
			throw new Exception( $"Tried to set {_what}, but no element exists." );
		byKey[$ _what ].active	= _active;
		return byKey[$ _what ];
		
	}
	static get	= function( _what ) {
		return byKey[$ _what ].thing;
		
	}
	static set	= function( _what, _visible = undefined, _active = undefined ) {
		if ( byKey[$ _what ] == undefined )
			throw new Exception( $"Tried to set {_what}, but no element exists." );
		byKey[$ _what ].visible	= _visible ?? byKey[$ _what ].visible;
		byKey[$ _what ].active	= _active  ?? byKey[$ _what ].active;
		dirty	= true;
		return byKey[$ _what ];
		
	}
	/// @param {string} _name
	/// @param {real} _depth
	/// @param {Struct.UIElement,Id.Instance,function,array} _thing
	/// @param {bool} _visible
	static add	= function( _name, _depth, _thing, _visible = true, _active = false ) {
		if ( is_method( _thing ))
			_thing	= [ _thing ];
		
		var _new	= { "thing" : _thing, "depth" : _depth, "visible" : _visible, "active" : _active };
		dirty	= true;
		
		byKey[$ _name ]	= _new;
		array_push( byId, _new );
		
		return _thing;
		
	}
	static remove	= function( _name ) {
		var _item	= byKey[$ _name ];
		byId	= array_filter( byId, method({"v" : _item }, function( _v ) {
			return _v != v;
			
		}));
		variable_struct_remove( byKey, _name );
		dirty	= true;
		
	}
	static update	= function( _x, _y ) {
		if ( not isInside( _x, _y ))
			return false;
		
		_x	-= x;
		_y	-= y;
		
		var _i = array_length( byId ); repeat( array_length( byId )) { --_i;
			if ( is_instanceof( byId[ _i ].thing, UIInteraction ) && byId[ _i ].active && byId[ _i ].thing.isInside( _x, _y )) {
				with( byId[ _i ].thing ) {
					if ( self == other.last ) {
						call( "step", _x, _y );
						return true;
						
					}
					with( other.last ) { call( "leave", _x, _y ); }
					call( "enter", _x, _y );
					other.last	= self;
					return true;
					
				}
				
			}
			
		}
		if ( last != noone ) {
			with( last ) { call( "leave", _x, _y ); }
			last	= noone;
			
		}
		return false;
		
	}
	/// @param {string} _what
	/// @param {real} _x
	/// @param {real} _y
	static call	= function( _what, _x, _y ) {
		_x	-= x;
		_y	-= y;
		
		var _i = array_length( byId ); repeat( array_length( byId )) { --_i;
			if ( is_instanceof( byId[ _i ].thing, UIInteraction ) && byId[ _i ].active && byId[ _i ].thing.isInside( _x, _y )) {
				with( byId[ _i ].thing ) { if call( _what, _x, _y ) return true; }
				
			}
			
		}
		return false;
		
	}
	static size	= function() {
		return array_length( byId );
		
	}
	x		= _x;
	y		= _y;
	w		= _width;
	h		= _height;
	byId	= [];
	byKey	= {};
	sorted	= [];
	dirty	= false;
	last	= noone;
	
}
 