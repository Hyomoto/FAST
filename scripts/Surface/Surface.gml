/// @func Surface
/// @param width
/// @param height
/// @param per_frame?
/// @wiki Core-Index
function Surface( _width, _height, _per_frame ) constructor {
	static create	= function() {
		surface_free( surface );
		
		surface	= surface_create( width, height );
		
	}
	static resize	= function( _width, _height ) {
		width	= _width;
		height	= _height;
		
		surface_free( surface );
		
	}
	static update	= function( _forced ) {
		if ( surface_exists( surface ) == false ) {
			create();
			
			redraw	= true;
			
		}
		if ( _forced == true ) {
			redraw	= true;
			
		}
		if ( redraw ) {
			redraw	= perFrame;
			
			return true;
			
		}
		return false;
		
	}
	static draw	= function( _x, _y ) {
		draw_surface( surface, _x, _y );
		
	}
	static draw_part = function( _l, _t, _w, _h, _x, _y ) {
		draw_surface_part( surface, _l, _t, _w, _h, _x, _y );
		
	}
	static set	= function() {
		surface_set_target( surface );
		
	}
	static per_frame	= function( _per_frame ) {
		perFrame	= _per_frame;
		
	}
	static refresh	= function() {
		redraw	= true;
		
	}
	static reset	= function() {
		if ( surface_get_target() == surface ) {
			surface_reset_target();
			
		}
		
	}
	static free		= function() {
		if ( surface_exists( surface ) ) {
			surface_free( surface );
			
		}
		
	}
	static is		= function( _data_type ) {
		return _data_type == Surface;
		
	}
	surface		= -1;
	width		= _width;
	height		= _height;
	redraw		= false;
	perFrame	= ( _per_frame == undefined ? true : _per_frame );
	
}
