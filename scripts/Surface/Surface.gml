/// @func Surface
/// @param {int} width	The width of the surface
/// @param {int} height	The height of the surface
/// @desc	A wrapper for the built-in GML surface type. Provides several quality of life improvements
///		such as automatic recreation of the surface should it goes missing, as well as reduced syntax
///		verbosity.  The surface can also be made to only update when requested by the user by using
///		the update function to check if it should be redrawn.  The example demonstrates this feature.
/// @example
//if ( surface.update() ) {
//	draw_clear( c_white );
//}
//surface.draw( 0, 0 );
/// @output The surface will be cached as white, and drawn
/// @wiki Core-Index
function Surface( _width, _height ) constructor {
	/// @param {int}	width	The width of the surface
	/// @param {int}	height	The height of the surface
	/// @desc	Resizes the internal surface, will also trigger a redraw of the surface.  If the provided
	///		arguments are not integers, InvalidArgumentType will be thrown.
	/// @returns self
	static resize	= function( _width, _height ) {
		if ( is_numeric( _width ) == false ) { throw new InvalidArgumentType( "resize", 0, _width, "integer" ); }
		if ( is_numeric( _height ) == false ) { throw new InvalidArgumentType( "resize", 1, _height, "integer" ); }
		
		width	= _width;
		height	= _height;
		
		surface_free( __Surface );
		
		return self;
		
	}
	/// @param {bool} *forced	optional: Whether to force an update
	/// @desc	Returns whether or not this surface needs to be updated.  This will return true
	///		if the internal surface has not been created, has been freed, redraw is flagged, or
	///		`forced` is set to true.
	/// @returns bool
	static update	= function( _forced ) {
		if ( _forced || surface_exists( __Surface ) == false ) {
			__Redraw	= true;
			
		}
		if ( __Redraw == true ) {
			__Redraw	= false;
			
			set();
			
			return true;
			
		}
		return false;
		
	}
	/// @desc	Flags the surface to be redrawn next time update is checked.
	/// @returns self
	static redraw	= function() {
		__Redraw	= true;
		
		return self;
		
	}
	/// @param {real}	x	A x position
	/// @param {real}	y	A y position
	/// @desc	Draws the surface at the given coordinates.
	/// @returns self
	static draw	= function( _x, _y ) {
		if ( surface_exists( __Surface ) == false ) { return; }
		
		reset();
		
		draw_surface( __Surface, _x, _y );
		
		return self;
		
	}
	/// @desc	If the internal surface exists, returns the id to it.  Otherwise, undefined is returned.
	/// @returns undefined or int
	static get	= function() {
		if ( surface_exists( __Surface ) ) { return __Surface; }
		
		return undefined;
		
	}
	/// @desc The same as calling `surface_set_target( surface.get() )`
	/// @returns self
	static set	= function() {
		if ( surface_exists( __Surface ) == false ) {
			surface_free( __Surface );
			
			__Surface	= surface_create( width, height );
			
		}
		if ( surface_get_target() != __Surface )
			surface_set_target( __Surface );
		
		return self;
		
	}
	/// @desc The same as calling `surface_reset_target()`
	/// @returns self
	static reset	= function() {
		if ( surface_get_target() == __Surface )
			surface_reset_target();
		
		return self;
		
	}
	/// @desc	Frees the internal surface.  Note, if you attempt to use the surface again
	///		it will be recreated.
	/// @returns self
	static free		= function() {
		if ( surface_exists( __Surface ) ) {
			surface_free( __Surface );
			
		}
		return self;
		
	}
	/// @var {int}	A pointer to the internal surface
	__Surface		= -1;
	// @desc when set to `true`, will trigger a surface redraw on the next frame
	__Redraw		= false;
	/// @var {int}	The width of the surface.  Changing this will not resize the surface, use resize() instead.
	width		= _width;
	/// @var {int}	The height of the surface.  Changing this will not resize the surface, use resize() instead.
	height		= _height;
	
}
