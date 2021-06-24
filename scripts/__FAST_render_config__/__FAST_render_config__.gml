// # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//								User-definable Macros
// # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

// # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// #							End of User Defines
// # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
FAST.feature( "FREN", "Render", (1 << 32 ) + ( 2 << 16 ) + 1, "06/22/2021" );

#macro RenderManager	( __FAST_render_config__() )

function __FAST_render_config__() {
	static instance	= new ( function() constructor {
		static set_resolution	= function( _width, _height ) {
			render_width	= _width;
			render_height	= _height;
			
		}
		static set_max_scale	= function( _scale ) {
			max_scale	= _scale;
			
		}
		static set_overscan		= function( _width, _height ) {
			overscan_width	= _width;
			overscan_height	= _height;
			
		}
		static set_precision	= function( _prec ) {
			precision	= _prec;
			
		}
		static set_fullscreen	= function() {
			window_set_fullscreen( true );
			
			
			
		}
		static set_window	= function( _width, _height ) {
			var _x	= ( display_get_width() - _width ) div 2;
			var _y	= ( display_get_height()- _height) div 2;
			
			view_xport[ 0 ]	= 0;
			view_yport[ 0 ] = 0;
			
			window_width	= _width;
			window_height	= _height;
			
			window_set_rectangle( _x, _y, window_width, window_height );
			
			window_set_fullscreen( false );
			
		}
		static create_camera	= function( _width, _height ) {
			if ( _width == undefined ) { _width = render_width; }
			if ( _height== undefined ) { _height= render_height; }
			
			if ( camera != undefined ) { camera.destroy(); }
			
			camera	= new Camera( _width, _height );
			
		}
		var _e	= new FrameEvent( FAST.ROOM_START, 0, function() {
			if ( render_width == undefined || render_height == undefined ) {
				render_width	= room_width;
				render_height	= room_height;
				
			}
			var _scale	= min( display_get_width() / render_width, display_get_height() / render_height );
			
			_scale	*= max_scale;
			_scale	-= ( _scale % 1 ) % precision;
			
			window_scale	= _scale;
			
			surface_resize( application_surface, render_width, render_height );
			
		}).once();
		__event	= new FrameEvent( FAST.ROOM_START, 0, function() {
			view_wport[ 0 ]		= render_width;
			view_hport[ 0 ]		= render_height;
			view_visible[ 0 ]	= true;
			
			view_enabled	= true;
			
			camera_set_view_size( view_camera[ 0 ], render_width, render_height );
			
			if ( fullscreen == false )
				set_window( floor( render_width * window_scale ), floor( render_height * window_scale ) );
			else
				set_fullscreen();
			
		});
		camera			= undefined;
		render_width	= undefined;
		render_height	= undefined;
		window_width	= 0;
		window_height	= 0;
		window_scale	= 1.0;
		max_scale		= 0.8;
		overscan_width	= 0;
		overscan_height	= 0;
		precision		= 1.0;
		fullscreen		= window_get_fullscreen();
		
	})();
	return instance;
	
}
