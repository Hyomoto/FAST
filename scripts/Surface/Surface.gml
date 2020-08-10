/// @func Surface
/// @param width
/// @param height
function Surface( _width, _height ) constructor {
	static create	= function() {
		surface	= surface_create( width, height );
		
	}
	static update	= function( _forced ) {
		if ( surface_exists( surface ) == false ) {
			create();
			
			redraw	= true;
			
		}
		if ( _forced != undefined ) {
			redraw	= _forced;
			
		}
		return redraw;
		
	}
	static draw	= function( _x, _y ) {
		draw_surface( surface, _x, _y );
		
	}
	static set	= function() {
		surface_set_target( surface );
		
	}
	static reset	= function() {
		surface_reset_target();
		
	}
	static free		= function() {
		if ( surface_exists( surface ) ) {
			surface_free( surface );
			
		}
		
	}
	surface	= -1;
	width	= _width;
	height	= _height;
	redraw	= false;
	
}
