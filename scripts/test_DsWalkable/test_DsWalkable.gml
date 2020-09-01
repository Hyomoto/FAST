/// @func test_DsLinkedList
function test_DsWalkable(){
	var _timer	= new Timer( "$S", 5 );
	
	syslog( "> Testing DsWalkable" );
	var _ex		= new DsWalkable();
	test_validator( "add()", 10, _ex, function( _ex ) {
		var _size	= _ex.size();
		
		_ex.add( irandom( 0xFFFF ) );
		
		return ( _ex.size() = _size + 1 );
		
	});
	test_validator( "next()", 10, _ex, function( _ex ) {
		var _seek;
		
		_ex.start();
		
		while ( _ex.has_next() ) {
			_seek	= _ex.next();
			
		}
		if ( _seek == _ex.final.value ) { return true; }
		
	});
	test_validator( "find()", 10, _ex, function( _ex ) {
		var _seek;
		
		_ex.start( irandom( _ex.size() ) );
		
		_seek	= _ex.next();
		
		if ( _ex.find( _seek ).value == _seek ) { return true; }
		
	});
	test_validator( "peek()", 20, _ex, function( _ex ) {
		var _seek	= _ex.peek();
		
		_ex.next();
		
		return _seek != undefined;
		
	});
	test_validator( "remove()", _ex.size() + 1, _ex, function( _ex ) {
		var _size	= _ex.size();
		
		repeat( irandom( 10 ) ) { _ex.next(); }
		_ex.remove( _ex.step );
		
		return ( _ex.size() == _size -1 || _ex.size == 0 == _size );
		
	});
	syslog( "test took ", _timer, " seconds" );
	
	_timer.reset();
	
}
