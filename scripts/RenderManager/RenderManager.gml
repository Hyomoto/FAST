/// @func RenderManager
/// @param *render_object
function RenderManager() {
	static render	= function( _render ) constructor {
		static update_window	= function() {
			if ( event != undefined ) { return; }
			
			event	= new EventerOnce( FAST.STEP, 0, undefined, function() {
				var _scale	= min( display_get_width() / render_width, display_get_height() / render_height );
				
				_scale	*= scale_value;
				_scale	-= ( _scale % 1 ) % precision;
				
				window_scale	= _scale;
				
				set_window( floor( render_width * window_scale ), floor( render_height * window_scale ) );
				event	= undefined;
				
				surface_resize( application_surface, render_width, render_height );
				
			});
			
		}
		static set_precision	= function( _precision ) {
			precision		= clamp( _precision, 0.1, 1.0 );
			
			update_window();
			
		}
		static set_resolution	= function( _width, _height ) {
			render_width	= _width;
			render_height	= _height;
			
			update_window();
			
		}
		static set_scale	= function( _percent ) {
			scale_value	= _percent;
			
			update_window();
			
		}
		static set_window	= function( _width, _height ) {
			var _x	= ( display_get_width() - _width ) div 2;
			var _y	= ( display_get_height()- _height) div 2;
			
			window_width	= _width;
			window_height	= _height;
			
			window_set_rectangle( _x, _y, window_width, window_height );
			
		}
		static use_view	= function( _true ) {
			bUseViews	= _true;
			
		}
		render_width	= 0;
		render_height	= 0;
		window_width	= 0;
		window_height	= 0;
		
		window_scale	= 1.0;
		precision		= 1.0;
		
		scale_value		= 0.9;
		
		bUseViews		= true;
		
		instance		= noone;
		event			= undefined;
		
		if ( FAST.start ) {
			instance_create_depth( 0, 0, 0, _render );
			
		} else {
			room_instance_add( room_first, 0, 0, _render );
			
		}
		
	}
	static instance	= new Feature( "FAST Render", "1.2", "07/12/2020", new render( argument_count > 0 ? argument[ 0 ] : FASTRender ) );
	return instance.struct;
	
}
