gamepad	= new GamepadXbox();
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

/// # TESTING THE DATABASE
var _string	= @"#define
value	10
#endef
foo = { bar = { dime = 10 }; word = 'ban'}
bar<-foo = { bar = 2}
#template foo.bar
doze = {#copy foo}
#tempend
list = {10, 20, 30, 40, 50, 60}
";
syslog( string_repeat( "~", 72 ) )
syslog( "\t\tDATABASE TEST" );

syslog( string_repeat( "~", 72 ) )

var _data	= new Database().from_string( _string );

show_debug_message( _data.toString() );
_data.write( "foo.bar", 0, FAST_DB_IDS.NODE );
_data.write( "foo.bar", "jello world!" );
//_data.remove( "foo" );
show_debug_message( _data.toString() );

//var _data	= new Database().from_string( @"
//foo[
	
//	bar[ 0, 1, 2, 3 ]
//]
//foo[ bar: 0 ]
//");
//show_debug_message( _data.toString() );

/// # END OF DATABASE TESTING

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
//RenderConfiguration.set_max_scale( 1.0 );
//RenderManager.set_overscan( 0, 64 );
//RenderManager.set_resolution( 1280, 720 );
//RenderManager.create_camera( 640, 360 );
//RenderManager.camera.set_offset( 320, 180 );
//RenderManager.camera.set_easing( ease_in_out_circ );
//var _i	= interface_start_box({width: "80%", height: "80%"})
//show_debug_message( _i );
//interface_end_box();
//var _eng	= new ScriptEngine().allow_global();//.set_output( new __OutputStream__() );;

//_eng.load_async( file_search( "txt", "", false ), function() { show_debug_message( "Done!" ) });
//var _scr	= new Script().from_string("trace \"Hello World!\"\ntrace \"Goodbye!\"");
//var _scr	= new Script().from_string(@"
//temp a
//yield while pas(a)
//trace 'Done!'
//");
//_scr.__Source	= "SCR";

//_pas.__Source	= "PAS";
//var _scr	= new NuScript().from_string(@"temp a
//while a > 0
// trace a
// put a - 1 into a
//" + "load \"nutest.txt\" as tmin\ntmin(10)");
//var _scr	= new NuScript().from_input( new TextFile().open("nutest.txt"));
//_scr.dump();
//_pas.dump();
//_scr.execute(20);

//if ( _scr.__Lump != undefined ) {
//	_scr	= new ScriptCoroutine( _scr, _scr.__Lump );
	
//	while ( _scr.is_yielded() ) {
//		_scr.execute();
		
//	}
	
//}
//_eng.bind( "pas", _pas );
//_eng.execute( _scr, 20 );

//while ( _eng.__Coroutines__.size() > 0 ) {
//	_eng.update();
	
//}

//var __break__	= function( _p, _word ) {
//	_p.mark();
//	while( _p.finished() == false ) {
//		_p.mark();
//		if ( _p.word( char_is_whitespace, false ) == _word) {
//			var _r	= _p.remaining();
//			_p.reset();
//			var _i	= _p.__Index;
//			_p.reset();
//			var _l	= _p.read( _i - _p.__Index );
//			_p.remaining();
						
//			return [ _l, _r ];
						
//		}
//		_p.unmark();
					
//	}
//	_p.reset();
				
//	return [ _p.remaining() ];
				
//}

//var _p	= new Parser().open( "yield 10" );
//_p.word( char_is_whitespace, false );

//syslog( __break__( _p, "while" ) );

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
function a(_a, _b) { // Should be slower
    _a += _b;
    return _a;
}

function b(_a, _b) {
    var _c = _a;
    _c += _b;
    return _c;
}
var _timer	= new Timer();
_timer.reset();

repeat( 100000 ) {
	a( 10, 20 );
	
}
var _one	= _timer.elapsed();

_timer.reset();

repeat( 100000 ) {
	b( 10, 20 );
	
}
show_debug_message( _one );
show_debug_message( _timer.elapsed() );
