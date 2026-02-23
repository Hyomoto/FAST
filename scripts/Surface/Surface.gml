function Surface( _width, _height ) constructor {
	/// @param {bool} _force Optional. Forces this function to return true. Default: false.
	/// @desc Returns whether or not the surface needs to be regenerated,
	///		and if so, sets it as the current draw target and returns true.
	///		This can be forced by setting _force to true, or by setting
	///		the dirty flag to true.
	static needsUpdate	= function( _force = dirty ) {
		if ( surface_exists( surface ) == false ) {
			surface	= surface_create( width, height );
			_force	= true;
			
		}
		dirty	= false;
		
		if ( _force )
			surface_set_target( surface );
		return _force;
		
	}
	/// @desc Sets the surface to be the current draw target.
	static set	= function() {
		needsUpdate();
		if ( surface_get_target() != surface )
			surface_set_target( surface );
		return self;
		
	}
	/// @desc Resets the surface from being the current draw target.
	static reset	= function() {
		if ( surface_get_target() == surface )
			surface_reset_target();
		return self;
		
	}
	/// @param {real} _x
	/// @param {real} _y
	/// @desc Draws the surface at the given coordinates.
	static draw		= function( _x, _y ) {
		reset();
		draw_surface( surface, _x, _y );
		
		return self;
		
	}
	/// @param {real} _x
	/// @param {real} _y
	/// @param {real} _l
	/// @param {real} _t
	/// @param {real} _w
	/// @param {real} _h
	/// @desc Draws the surface at the given coordinates.
	static drawPart		= function( _x, _y, _l, _t, _w, _h ) {
		reset();
		draw_surface_part( surface, _l, _t, _w, _h, _x, _y );
		
		return self;
		
	}
	/// @param {real} _width
	/// @param {real} _height
	/// @desc	Resizes the surface to the given dimensions.
	static resize	= function( _width, _height ) {
		width	= _width;
		height	= _height;
		if ( surface_exists( surface ))
			surface_free( surface );
		return self;
		
	}
	/// @param {real,Constant.Color} _color	Optional. Used to override style.
	/// @param {real} _alpha Optional. Used to override style.
	static clear	= function( _color = color, _alpha = alpha) {
		if ( surface_get_target() == surface )
			draw_clear_alpha( _color, _alpha );
		return self;
		
	}
	/// @param {real,Constant.Color} _color
	/// @param {real} _alpha
	static style	= function( _color, _alpha ) {
		color	= _color;
		alpha	= _alpha;
		
		return self;
		
	}
	/// @desc Frees the surface from memory. Note it will be regenerated
	///		if you call set() or needsUpdate() on this struct.  This
	///		function is normally used before you would discard this
	///		struct.
	static destroy	= function() {
		if ( surface_exists( surface ))
			surface_free( surface );
		return self;
		
	}
	surface	= -1;
	width	= _width;
	height	= _height;
	dirty	= false;
	color	= c_white;
	alpha	= 0.0;
	
}
