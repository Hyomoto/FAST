fast	= FASTManager();

log( string_repeat( "~", 40 ) );
log( fast );
log( string_repeat( "~", 40 ) );

var _i = 0; repeat( ds_list_size( fast.features ) ) {
	var _feature	= fast.features[| _i++ ];
	
	log( _feature );
	
}
fast.start	= true;
fast.call_events( fast.CREATE );
