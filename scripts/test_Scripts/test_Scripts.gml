function test_Scripts(){
	var _timer	= new Timer( "$S", 5 );
	
	//var _script	= global.eng.scripts[? "testB" ];
	
	//_script.validate( global.eng );
	global.eng.run_script( "testA" );
	//test_validator( "ScriptEngine", 1, global.eng, function( _eng ) {
	//	//var _script	= global.eng.funcs[? "test_traversal" ];
	//	//var _last	= undefined;
	//	//var _line	= 0;
		
	//	//while( _script.has_next( _last ) ) {
	//	//	_last	= _script.next( _last );
			
	//	//	if ( is_string( _last.value ) ) {
	//	//		syslog( _line++, " ", _last.value );
				
	//	//	} else {
	//	//		syslog( _line++, " ", _last.value.expression );
				
	//	//	}
			
	//	//}
	//	global.eng.run_script( "testA" );
		
	//	return true;
		
	//});
	syslog( "Execute took ", _timer, " seconds." );
	syslog( "Executed ", global.eng.lines, " lines." );
	
	global.eng.lines	= 0;
	
}
