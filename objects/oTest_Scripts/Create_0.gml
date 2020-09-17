timer	= new Timer( "$S", 5 );

global.eng	= new ScriptEngine( "test", undefined, true );

syslog( "Compile took ", timer, " seconds." );

global.eng.set_value( "quest", true );

global.eng.load_async( "test/", false, 1000 );

//event_user( 0 );

//wait	= SPEED;
//load	= file_get_directory( "test/" );

//#macro SPEED	100
