function test_Scripts(){
	test_validator( "ScriptEngine", 1, global.eng, function( _eng ) {
		var _script	= global.eng.scripts[? "test" ];
		var _last	= undefined;
		var _line	= 0;
		
		while( _script.has_next( _last ) ) {
			_last	= _script.next( _last );
			
			if ( is_string( _last.value ) ) {
				syslog( _line++, " ", _last.value );
				
			} else {
				syslog( _line++, " ", _last.value.expression );
				
			}
			
		}
		global.eng.run_script( "test" );
		
		return true;
		
	});
	
}
