test_validator( "ScriptEngine", 1, global.eng, function( _eng ) {
	global.eng.run_script( "test" );
	
	return true;
	
});

//var _script	= global.eng.scripts[? "test" ];

//var _link	= undefined;

//while ( _script.has_next( _link ) ) {
//	_link	= _script.next( _link );
	
//	syslog( _link.value );
		
//}
