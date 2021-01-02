#macro RANDOM rand.between( 10, 20 )

var _event	= new FrameEvent( FAST.CREATE, 0, 0, function() {
	rand	= new LRand();
	
	table = array_create( 10, 0 );
	
	repeat ( 10 ) {
		var _i  = 0; repeat( 10 ) {
			table[ _i++ ]	= RANDOM;
			
		}
		show_debug_message( table );
		
	}
		
});
