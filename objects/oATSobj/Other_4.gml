__run();

watch	= [ (room_width - sprite_get_width( gfx_FAST_watch )) div 2, (room_height - sprite_get_height( gfx_FAST_watch)) div 3];
logo	= [ (room_width - sprite_get_width( gfx_fast )) div 2, watch[ 1 ] + sprite_get_height( gfx_FAST_watch ) - 32 ];
box		= [ 0, ( RenderManager().render_height div 3 ) * 2, RenderManager().render_width, RenderManager().render_height div 3 ];

surface.resize( box[2] - bufferW * 2, box[3] - bufferH * 2 );

lines	= box[3] / string_height( "A" );

color	= [
	0xF0F0F0,
	0x050505
];
