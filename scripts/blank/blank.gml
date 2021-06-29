//syslog( string_repeat( "~", 72 ) )
//syslog( "\t\tDATABASE TEST" );

//syslog( string_repeat( "~", 72 ) )

var _data	= new Database().from_input( new Queue().push( @"#define
True	1
False	0
#endef" ));

show_debug_message( new StringExpression().from_string( "1 * (2 + 5)" ).evaluate() );

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
//var _scr	= new Script().from_input( new TextFile().open("test.txt"));

//_eng.execute( _scr, 10 );
//_scr.execute( 10 );
