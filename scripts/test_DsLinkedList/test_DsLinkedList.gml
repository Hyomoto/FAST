/// @func test_DsLinkedList
function test_DsLinkedList(){
	var _timer	= new Timer( "$S", 5 );
	
	syslog( "> Testing DsLinkedList" );
	var _ex		= new DsLinkedList( 10, 20, 30 );
	test_validator( "add()", 1, _ex, function( _ex ) {
		var _value	= 40;
		repeat ( 10 ) {
			_ex.add( _value );
			
			_value	+= 10;
			
		}
		return _ex.size() == 13;
		
	});
	test_validator( "remove()", 10, _ex, function( _ex ) {
		var _size	= _ex.size();
		
		_ex.remove( _ex.link );
		
		return _ex.size() == _size - 1;
		
	});
	test_validator( "peek()", 10, _ex, function( _ex ) {
		return _ex.peek() == 110;
		
	});
	test_validator( "find()", 10, _ex, function( _ex ) {
		return _ex.find( 130 ) == _ex.last;
		
	});
	test_validator( "poke()", 10, _ex, function( _ex ) {
		var _size	= _ex.size();
		
		_ex.poke( 10 );
		
		return _ex.size() == _size + 1 && _ex.peek() == 10;
		
	});
	test_validator( "toArray()", 1, _ex, function( _ex ) {
		return is_array( _ex.toArray() );
		
	});
	test_validator( "toString()", 1, _ex, function( _ex ) {
		return is_string( _ex.toString() );
		
	});
	test_validator( "clear()", 10, _ex, function( _ex ) {
		_ex.clear();
		
		return _ex.size() == 0 && _ex.last == undefined && _ex.link == undefined;
		
	});
	test_validator( "is()", 20, _ex, function( _ex ) {
		return _ex.is( DsLinkedList );
		
	});
	syslog( "test took ", _timer, " seconds" );
	
	_timer.reset();
	
}
