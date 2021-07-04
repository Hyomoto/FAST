//var _pf	= infix_to_postfix("(a+b)*(c+d)");
//syslog( _pf );
//var _ex	= expression_parse( "( a + b ) * ( c + d )" );
//syslog( "%=%", _ex.toString(), expression_evaluate( _ex, {a:2, b:4, c:4, d:6}));
//syslog( evaluate_string( "100 * ( 2 + 12 ) / 14" ));

//var _ex	= expression_parse("a.b * ( b + c ) / d");
//syslog( "%=%", _ex.toString(), _ex.evaluate({a:{b:100}, b:2, c:12, d:14}) );
//var _n	= new ( function( _value ) constructor {
//	static value	= function() { return __Value; }
//	__Value = _value;
	
//})(10);

//var _ex	= expression_parse("n.value() + 10");
//syslog( "%=%", _ex.toString(), _ex.evaluate({n: _n }) );
//expression_parse( "a + ( 2 + 3 )" );

//syslog( string_repeat( "~", 72 ) )
//syslog( "\t\tDATABASE TEST" );

//syslog( string_repeat( "~", 72 ) )

//var _data	= new Database().from_string( @"
//foo[
	
//	bar[ 0, 1, 2, 3 ]
//]
//foo[ bar: 0 ]
//");
//show_debug_message( _data.toString() );
//var _string	= @"#define
//value	10
//#endef
//foo = { bar = { dime = 10 }; word = 'ban'}
//bar<-foo = { bar = 2}
//#template foo.bar
//doze = {#copy foo}
//#tempend
//list = {10, 20, 30, 40, 50, 60}
//";
//var _p	= new Parser().open( _string );
//var _q	= new Queue();

//while ( _p.finished() == false ) {
//	_q.push( _p.word( char_is_linebreak, false ));
	
//}
//_p.open( _q );
//syslog( "START" );
//while ( _p.finished() == false ) {
//	syslog( _p.word( char_is_whitespace, false ));
	
//}

//var _data	= new Database().from_input( _q );

//show_debug_message( _data.toString() );
//syslog( "write" );
//_data.write( "foo.bar", 0, FAST_DB_IDS.NODE );
//_data.write( "foo.bar", "jello world!" );
//_data.remove( "foo" );
//syslog( "output" );
//show_debug_message( _data.toString() );
//RenderManager.set_overscan( 0, 64 );
//RenderManager.set_resolution( 1280, 720 );
//RenderManager.create_camera( 640, 360 );
//RenderManager.camera.set_offset( 320, 180 );
//RenderManager.camera.set_easing( ease_in_out_circ );
//var _i	= interface_start_box({width: "80%", height: "80%"})
//show_debug_message( _i );
//interface_end_box();
//var _eng	= new ScriptEngine().set_output( new __OutputStream__() );;

//var _scr	= new Script().from_string("trace \"Hello World!\"\ntrace \"Goodbye!\"");
//var _scr	= new Script().from_string("func a\nwhile a > 0\n put a - 1 into a\ntrace \"Done!\"");
var _scr	= new Script().from_input( new TextFile().open("test.txt"));

//_eng.execute( _scr, 10 );
_scr.execute( undefined, undefined, 10 );
//var _names	= array_create( 20 );

//var _i = 0; repeat( array_length( _names )) {
//	//_names[ _i++ ]	= choose("Ealey", "Mode", "Nader", "Siggers", "Nodine", "Magnani", "Durrah", "Hambrick", "Monteiro", "Treadwell", "Romriell", "Cassara", "Berrios", "Schooley", "Eoff", "Mederos", "Quinby", "Asay", "Stetson", "Azevedo");
//	_names[ _i++ ]	= {
//		first: choose("Kimberlee", "Shenna", "Bebe", "Stefany", "Jamee", "Cristen", "Gertrude", "Shanita", "Stacee", "Pandora", "Martin", "Ilda", "Sue", "Una", "Hyon", "Bobbye", "Angelo", "Karie", "Clarice", "Awilda"),
//		last: choose("Ealey", "Mode", "Nader", "Siggers", "Nodine", "Magnani", "Durrah", "Hambrick", "Monteiro", "Treadwell", "Romriell", "Cassara", "Berrios", "Schooley", "Eoff", "Mederos", "Quinby", "Asay", "Stetson", "Azevedo")
//	}
//}
//array_quicksort( _names, new Sort().by( "last" ).thenBy( "first" ) );

////("Kimberlee", "Shenna", "Bebe", "Stefany", "Jamee", "Cristen", "Gertrude", "Shanita", "Stacee", "Pandora", "Martin", "Ilda", "Sue", "Una", "Hyon", "Bobbye", "Angelo", "Karie", "Clarice", "Awilda")
////("Ealey", "Mode", "Nader", "Siggers", "Nodine", "Magnani", "Durrah", "Hambrick", "Monteiro", "Treadwell", "Romriell", "Cassara", "Berrios", "Schooley", "Eoff", "Mederos", "Quinby", "Asay", "Stetson", "Azevedo")
//var _i = 0; repeat( array_length( _names )) {
//	//syslog( "%, %", _names[ _i ] );
//	syslog( "%, %", _names[ _i ].last, _names[ _i ].first );
//	++_i;
//}
