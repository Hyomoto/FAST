test_validator( "ScriptEngine", 1, global.eng, function( _eng ) {
	var _func	= _eng.funcs[? "test_if" ];
	var _file, _seek;
	
	if ( _func == undefined ) { return false; }
	
	_file	= _func.file;
	_file.reset();
	
	while ( _file.eof() == false ) {
		_seek	= _file.read();
		
		syslog( _seek );
		
	}
	return true;
	
});

global.eng.do_script( "test" );
