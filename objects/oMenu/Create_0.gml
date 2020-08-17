interface	= new PointerInterface( new ShapeRectangle( x, y, 100, 50 ) );

PointerManager().add( interface, 0, true );
PointerManager().set_enter( interface, interface.enter );
PointerManager().set_leave( interface, interface.leave );

interface.add( new ShapeCircle( 0, 0, 30 ), 0, false );
interface.add( new ShapeRectangle( 15, 0, 30, 20 ), -1, false );

origin_x	= x;

interface.set_leave( interface.objects[ 0 ].target, function() {
	syslog( "done!" );
	
});

interface.set_step( interface.objects[ 0 ].target, function() {
	syslog( "hello world!" );
	
});
