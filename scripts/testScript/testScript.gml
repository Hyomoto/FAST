#macro Critical:ERROR_LEVEL	1
#macro Nonfatal:ERROR_LEVEL	2
#macro Notify:ERROR_LEVEL	3

var _timer	= new Timer( "$S", 5 );

//var _ex		= new ScriptExpression( "(0 + not real->0) * 2 + val" );
//var _ex1		= new ScriptStatement( "set value to \"Hello World!\"" );
//var _ex2		= new ScriptStatement( "trace( value )" );

//var _file	= new FileScript( "test/test.txt" );

//gc_enable( false )


syslog( "compilation took ", _timer, " seconds" );

//_eng.execute_string( "set value to \"Hello\"" );
//_eng.execute_string( "set value to value + \" World!\"" );
//_eng.execute_string( "trace( value )" );

//syslog( "Running test..." );
//global.eng.do_script( "test" );
//syslog( "execution took ", _timer, " seconds" );
