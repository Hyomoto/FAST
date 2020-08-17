#macro Critical:ERROR_LEVEL	1
#macro Nonfatal:ERROR_LEVEL	2
#macro Notify:ERROR_LEVEL	3

//var _scr	= new ScriptParser( "  ab= \" h+a)i \"+10+( 40 * 12 ) " )

//while( _scr.has_next() ) {
//	syslog( "result : ", _scr.next() );
	
//}
global.engine	= new ScriptEngine( "scripts/test.txt", true )// "scripts/", true );

var _timer	= new Timer( "evaluation took $S seconds", 5 );

global.engine.enqueue( "test" );

//_a	= new ScriptExpression( "a.b = 10 * 2 + ( 15 + 1 ) * ( ( 6 ) * 2 )" );
//_b	= new ScriptExpression( "1 && 0" );
//_c	= new ScriptExpression( "1 || 1" );
//_d	= new ScriptExpression( "1 | 4" );
//_e	= new ScriptExpression( "7 & 3" );
//_f	= new ScriptExpression( "7 > 3" );
//_g	= new ScriptExpression( "7 < 3" );
//_h	= new ScriptExpression( "7 >= 3" );
//_i	= new ScriptExpression( "7 <= 3" );

//syslog( _timer );
//var _timer	= new Timer( "evaluate took $S seconds", 5 );

//script_evaluate( _a, global.engine.local, global.engine );
//script_evaluate( _b, global.engine.local, global.engine );
//script_evaluate( _c, global.engine.local, global.engine );
//script_evaluate( _d, global.engine.local, global.engine );
//script_evaluate( _e, global.engine.local, global.engine );
//script_evaluate( _f, global.engine.local, global.engine );
//script_evaluate( _g, global.engine.local, global.engine );
//script_evaluate( _h, global.engine.local, global.engine );
//script_evaluate( _i, global.engine.local, global.engine );

//syslog( global.engine.execute_string( "10 * 2 + ( 15 + 1 ) * ( ( 6 ) * 2 )" ) );
//syslog( global.engine.execute_string(  ) );
//syslog( global.engine.execute_string(  ) );
//syslog( global.engine.execute_string(  ) );
//syslog( global.engine.execute_string(  ) );
//syslog( global.engine.execute_string(  ) );
//syslog( global.engine.execute_string(  ) );
//syslog( global.engine.execute_string(  ) );
//syslog( global.engine.execute_string(  ) );
// 10 + 16 * 12
//syslog( global.engine.get_value( "a" ) );
//syslog( 10 * 2 + ( 15 + 1 ) * ( ( 6 ) * 2 ) );
syslog( _timer );

//global.engine.run( "test" );

//var _ex	= new ScriptExecution( "This is the script execution" );

//syslog( _ex );

//ScriptEngine.run( "function" );

//var _walk	= new DsWalkable();

//_walk.add( "a" );
//_walk.add( "b" );
//_walk.add( "c" );
//_walk.add( "d" );
//_walk.add( "e" );

//_walk.remove( _walk.find( "a" ) );
//_walk.remove( _walk.find( "e" ) );
//_walk.remove( _walk.find( "c" ) );

//syslog( _walk );

//var _a	= [ 0, 2, 3, "soda", {}, 4, 55, 123, "bears", "jumple", 45, 5120, 12, 44, 10, 200, 231, 40, 4, 1, 240, {}, 23104, {}, 23, 1, 45, 10, 15 ];
//var _b	= [ "soda", 10, 0, 44, "words", {}, 312, 55, 14, 10, 22, 34, 55, 102, 24, 7178, 2190, 10, 24478, 10, 2193, 44, 0, 12, 2, 3, 4, 5, 6, 7, 8, 9, 0, 10, 1, 1, 1, 1, 1 ];

//var _timer	= new Timer("concat : $S seconds", 4 );
//syslog( array_concat( _a, _b ) );

//syslog( _timer );

//var _timer	= new Timer("union : $S seconds", 4 );
//syslog( array_union( _a, _b ) );

//syslog( _timer );

//var _timer	= new Timer("difference : $S seconds", 4 );
//syslog( array_difference( _a, _b ) );

//syslog( _timer );

//var _array	= new Array( [ 0, 1, 2, 3, 3, 3, 4, 5, 6, 6, 1, 2, 3, 4 ] );

//_array.concat( [ 0, 2, 10, 15, 44, 0, 3, 1, 3, 4, 5 ] );

//syslog( _array );

//syslog( execute_julien( "julien.j", "enemy_test" ) )
//syslog( execute_julien( "julien.j", "birds" ) );

//var _chain	= new DsQueue();

//_chain.enqueue( "A" );
//_chain.enqueue( "B" );
//_chain.enqueue( "C" );
//_chain.enqueue( "D" );

//_chain.dequeue();

//_chain.remove( _chain.find( "B" ) );

//syslog( _chain );
//syslog( _chain.size() );

//var _parse	= new Parser( "This is the sentence I want to break!" );
//while ( _parse.has_next() ) {
//	syslog( _parse.next() );
	
//}
//var _parse	= new Parser( "		This is the		 sentence I	 want to break       	!		" );
//while ( _parse.has_next() ) {
//	syslog( _parse.next() );
	
//}

//global.scripts	= new ScriptEngine( "test/", true );

//global.scripts.run( "localVar" );

//ScriptManager().load( "test/file.text" );

//var _script	= new Script();

//syslog( filename_name( "test/" ) );
//syslog( filename_path( "test/" ) );

//global.mouse	= new PointerDevice( "left", "middle", "right" );
//global.mouse.left.bind( new MouseButton( mb_left ) );
//global.mouse.middle.bind( new MouseButton( mb_middle ) );
//global.mouse.right.bind( new MouseButton( mb_right ) );

//PointerManager().set_input( global.mouse );
//PointerManager().set_shape( new ShapeEllipses( 0, 0, 200, 100 ) );

//var _input	= new MouseInterface( undefined );

//_input.update( 10, 10 );

//syslog( _input.active );

//_input.add( 0, 10 );
//_input.add( 1, 1 );
//_input.add( 2, 23 );
//_input.add( 3, -3 );
//syslog( _input.objects );
//_input.add( 4, 4 );
//_input.add( 5, 400 );
//_input.add( 6, -8, true );
//syslog( _input.objects );
//_input.remove( 0 );

//syslog( _input.objects );

//var _array	= new ArrayStrings( [ "hello", "hampster", "HolODECK", "HELLFIRE", "Honolulu", "Homeopathy" ] );
//syslog( string_repeat( "~", 10 ) );
//syslog( _array );

//_array.sort( true );

//syslog( string_repeat( "~", 10 ) );
//syslog( _array );

//_array.sort( false );

//syslog( string_repeat( "~", 10 ) );
//syslog( _array );


//var _node	= database_load( "database.ffd" );

//ds_node_dump( _node );


//var _node	= new DsNode();

//_node.set( "a", 5 );

//syslog( _node.get( "a" ) );

//ds_node_dump( _node, 0 );


//syslog( json_encode( _node.table ) );


//var _file	= new FileText( "test.txt", true );
//while ( _file.eof() == false ) {
//	syslog( _file.read() );
	
//}
//_file.write( "HAPPY DAYS!" );

//_file.close();
