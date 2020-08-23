function test_Scripts(){
	test_validator( "ScriptEngine", 1, global.eng, function( _eng ) {
		global.eng.do_script( "test" );
		
		return true;
	
	});
	
}
