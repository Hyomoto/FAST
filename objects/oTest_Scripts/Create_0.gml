timer	= new Timer( "$S", 5 );
event	= undefined;

global.eng	= new ScriptEngine( "test", undefined, true ).inherit();

syslog( "Compile took ", timer, " seconds." );

global.eng.set_value( "quest", true );

global.eng.load( "test/", false, "*.*", true );
//global.eng.scripts[? "trace" ]	= function() {}

//event_user( 0 );

//wait	= SPEED;
//load	= file_get_directory( "test/", "*.*", true );

//#macro SPEED	100

//var _formatter	= new StringFormatter("\t:strip,\n:strip,[:strip,]:strip, :strip,{:pull");

//syslog( _formatter.format( "[DEMO] {" ) );
