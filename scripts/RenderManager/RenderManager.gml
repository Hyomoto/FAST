/// @func RenderManager
/// @param *render_object
function RenderManager( _render ) {
	static render	= function( _render ) constructor {
		static set_resolution	= function( _width, _height ) {
			render_width	= _width;
			render_height	= _height;
			
			set_window( floor( _width * window_scale ), floor( _height * window_scale ) );
			
			surface_resize( application_surface, _width, _height );
			
		}
		static set_scale	= function( _percent ) {
			var _scale	= min( display_get_width() / render_width, display_get_height() / render_height );
			
			_scale	*= _percent;
			_scale	-= ( _scale % 1 ) % precision;
			
			set_window( floor( render_width * _scale ), floor( render_height * _scale ) );
			
			window_scale	= _scale;
			
		}
		static set_window	= function( _width, _height ) {
			var _x	= ( display_get_width() - _width ) div 2;
			var _y	= ( display_get_height()- _height) div 2;
			
			window_set_rectangle( _x, _y, _width, _height );
			
			window_width	= _width;
			window_height	= _height;
			
		}
		render_width	= 0;
		render_height	= 0;
		window_width	= 0;
		window_height	= 0;
		
		window_scale	= 1.0;
		precision		= 1.0;
		
		instance		= noone;
		
		_render	= ( is_undefined( _render ) ? FASTRender : _render );
		
		if ( FAST.start ) {
			instance_create_depth( 0, 0, 0, FASTRender );
			
		} else {
			room_instance_add( room_first, 0, 0, FASTRender );
			
		}
		
	}
	static instance	= new Feature( "FAST Render", "1.2", "07/12/2020", new render() );
	return instance.struct;
	
}
