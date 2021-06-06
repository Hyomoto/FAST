draw_self();

draw_set_color( image_index ? c_black : c_white );
draw_set_halign( fa_center );
draw_set_valign( fa_middle );

draw_text( x + sprite_width div 2, y + sprite_height div 2, "Run" );

draw_set_halign( fa_left );
draw_set_valign( fa_top );
