#macro Critical:ERROR_LEVEL	1
#macro Nonfatal:ERROR_LEVEL	2
#macro Notify:ERROR_LEVEL	3

global.mouse	= new PointerDevice( "left", "middle", "right" );
global.mouse.left.bind( new MouseButton( mb_left ) );
global.mouse.middle.bind( new MouseButton( mb_middle ) );
global.mouse.right.bind( new MouseButton( mb_right ) );

PointerManager().set_input( global.mouse );
//PointerManager().set_shape( new ShapeEllipses( 0, 0, 200, 100 ) );

//var _input	= new MouseInterface( undefined );

//_input.update( 10, 10 );

//log( _input.active );

//_input.add( 0, 10 );
//_input.add( 1, 1 );
//_input.add( 2, 23 );
//_input.add( 3, -3 );
//log( _input.objects );
//_input.add( 4, 4 );
//_input.add( 5, 400 );
//_input.add( 6, -8, true );
//log( _input.objects );
//_input.remove( 0 );

//log( _input.objects );

//var _array	= new ArrayStrings( [ "hello", "hampster", "HolODECK", "HELLFIRE", "Honolulu", "Homeopathy" ] );
//log( string_repeat( "~", 10 ) );
//log( _array );

//_array.sort( true );

//log( string_repeat( "~", 10 ) );
//log( _array );

//_array.sort( false );

//log( string_repeat( "~", 10 ) );
//log( _array );


//var _node	= database_load( "database.ffd" );

//ds_node_dump( _node );

//var _file	= new FileText( "test.txt", true );
//while ( _file.eof() == false ) {
//	log( _file.read() );
	
//}
//_file.write( "HAPPY DAYS!" );

//_file.close();
