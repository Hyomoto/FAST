draw_clear( 0xF0F0F0 );

draw_sprite_tiled( gfx_fast2, 0, x | 0, y | 0 );

draw_sprite( gfx_FAST_watch, 0, watch[0], watch[1] );
draw_sprite( gfx_fast, 0, logo[0], logo[1] );

draw_sprite_stretched( gfx_ATS_box, 0, box[ 0 ], box[ 1 ], box[ 2 ], box[ 3 ] );
if ( surface.update() ) {
	surface.set();
		var _th	= string_height( "A" );
		
		draw_clear_alpha( c_white, 0.0 );
		
		draw_set_color( color[ 0 ] );
		
		var _y = surface.height - _th, _i = array_length( list ) - start; repeat( lines ) { --_i;
			if( _i < 0 ) { break; }
			
			draw_text( 0, _y, list[ _i ] );
			
			_y	-= _th;
			
		}
		
	surface.reset();
	
}
surface.draw( box[ 0 ] + bufferW, box[ 1 ] + bufferH );
