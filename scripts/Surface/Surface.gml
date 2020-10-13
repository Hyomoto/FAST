/// @func Surface
/// @param {int} width
/// @param {int} height
/// @desc Creates an internally managed surface with some optional optimizations. In the example, the
//		surface is cached and will only update when it's called to, or if the surface goes missing
//		in memory.
/// @example
// if ( surface.update() ) {
//  surface.set();
//    draw_clear( c_white );
//  surface.reset();
//}
//surface.draw( 0, 0 );
/// @wiki Core-Index
function Surface( _width, _height ) constructor {
	/// @desc Recreates the internal surface
	static create	= function() {
		surface_free( surface );
		
		surface	= surface_create( width, height );
		
	}
	/// @desc Resizes the internal surface, will trigger a recreation of the surface.
	static resize	= function( _width, _height ) {
		width	= _width;
		height	= _height;
		
		surface_free( surface );
		
	}
	/// @desc Returns whether or not this surface needs to be updated.  This will return true if the internal surface has not been created, or has been freed, redraw is flagged, or `forced` is set to true.
	/// @param {bool} forced Forces the surface to update, Default: false
	/// @returns bool
	static update	= function( _forced ) {
		if ( _forced || surface_exists( surface ) == false ) {
			redraw	= true;
			
		}
		if ( redraw == true ) {
			redraw	= false;
			
			return true;
			
		}
		return false;
		
	}
	/// @desc Draws the surface at the given coordinates
	static draw	= function( _x, _y ) {
		if ( surface_exists( surface ) == false ) { return; }
		
		draw_surface( surface, _x, _y );
		
	}
	/// @desc Draws the defined part of the surface at the given coordinates
	/// @param {int} left The left side of the part to draw
	/// @param {int} top The top side of the part to draw
	/// @param {int} right The right side of the part to draw
	/// @param {int} bottom The bottom side of the part to draw
	static draw_part = function( _l, _t, _w, _h, _x, _y ) {
		if ( surface_exists( surface ) == false ) { return; }
		
		draw_surface_part( surface, _l, _t, _w, _h, _x, _y );
		
	}
	/// @desc The same as calling `surface_set_target( surface )`
	static set	= function() {
		if ( surface_exists( surface ) == false ) { create(); }
		
		surface_set_target( surface );
		
	}
	//static per_frame	= function( _per_frame ) {
	//	perFrame	= _per_frame;
		
	//}
	//static refresh	= function() {
	//	redraw	= true;
		
	//}
	/// @desc The same as calling `surface_set_target( surface )`
	static reset	= function() {
		if ( surface_get_target() == surface ) {
			surface_reset_target();
			
		}
		
	}
	/// @desc Frees the internal surface.  Note, if you attempt to use the surface again it will be recreated.
	static free		= function() {
		if ( surface_exists( surface ) ) {
			surface_free( surface );
			
		}
		
	}
	static is		= function( _data_type ) {
		return _data_type == Surface;
		
	}
	// @desc the internal surface
	surface		= -1;
	// @desc the width of the surface, note: changing this will _not_ resize the surface! use resize() instead
	width		= _width;
	// @desc the width of the surface, note: changing this will _not_ resize the surface! use resize() instead
	height		= _height;
	// @desc when set to `true`, will trigger a surface redraw on the next frame
	redraw		= false;
	// when set to `false`, surface.update() will only return `true` if redraw is set or the surface disappears from memory. Default: true
	// perFrame	= ( _per_frame == undefined ? true : _per_frame );
	
}
