draw_set_color( interface.active ? c_white : c_dkgray ) ;

interface.shape.draw();

var _i = interface.size - 1; repeat( interface.size ) {
	draw_set_color( PointerManager().target == interface.objects[ _i ].target ? c_white : c_dkgray ) ;

	interface.objects[ _i ].target.draw( x, y, true );
	
	--_i;
	
}
