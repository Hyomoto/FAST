// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ats_IterableList( _type ){
// # TOTAL METHODS LOOKING TO TEST
	var _methods	= 18;
	
	__iter		= new _type().push( "a", "b", "c" );
	
	static _test_method	= function( _a, _b, _c ) {
		if ( is_array( _a ) == false ) { _a = [ _a ]; }
		if ( _c == undefined ) { _c = function( _r ) { return __iter.toString(); } }
		
		try {
			assert_equal( _c( do_method( _a ) ), _b, "Method " + to_func( _a ) + " failed." )
		} catch ( _ex ) {
			assert_equal( instanceof( _ex ), _b, "Method " + to_func( _a ) + " generated an exception!" );
			
		}
		log_method( _a[ 0 ] );
		
	}
	static _test_exception	= function( _a, _b ) {
		try {
			do_method( _a );
			
		} catch( _ex ) {
			assert_equal( error_type( _ex ), _b, "Method " + to_func( _a ) + " threw wrong exception." );
			return;
		}
		assert_equal( "no exception", script_get_name( _b ), "Method " + to_func( _a ) + " did not throw exception." );
		
	}
	static _test_func	= function( _a, _b, _c ) {
		assert( _c( _a, _b ), "Method " + _a + "() failed." )
		
	}
	static _returns	= function( _r ) { return _r; }
	
// # TEST BODY
	_test_exception( ["insert",4,"a"], IndexOutOfBounds );
	
	_test_exception( ["filter", "bob", "a"], InvalidArgumentType );
	
	_test_exception( ["remove", "d"], ValueNotFound );
	
	_test_method( "size", 3, _returns);
	
	_test_method( "empty", bool( false ), _returns );
	
	_test_method( ["index",0], "a", _returns );
	
	_test_method( ["next"], "a", _returns );
	_test_method( ["next"], "b", _returns );
	_test_method( ["next"], "c", _returns );
	_test_method( ["next"], __iter.EOL, _returns );
	
	_test_method( ["remove","b"],"[a,c]" );
	
	_test_method( ["index",1], "c", _returns );
	
	_test_method( ["insert",2,"a"],"[a,c,a]" );
	
	_test_method( ["pop",0],"[c,a]" );
	
	_test_method( "pop","[c]" );
	
	__iter.allow_duplicates( false );
	array_push( __tests, "allow_duplicates" );
	
	_test_method( ["push", "c", "c"], "[c]" );
	
	__iter.allow_duplicates( true );
	
	_test_method( ["push","1","2","3","c"],"[c,1,2,3,c]" );
	
	_test_method( "reverse","[c,3,2,1,c]", function( _r ) { return _r.toString(); } );
	
	_test_method( ["contains", "c", "3", "1", "3" ], true, _returns );
	
	_test_method( ["find", "c" ], 0, _returns );
	_test_method( ["find", "1" ], 1, _returns );
	_test_method( ["find", "2" ], 2, _returns );
	_test_method( ["find", "3" ], 3, _returns );
	
	_test_method( ["count", "c" ], 2, _returns );
	
	_test_method( ["contains", "b" ], false, _returns );
	
	_test_method( "unique", "[1,2,3,c]", function( _r ) { return _r.toString(); } );
	
	_test_method( ["copy"],"[c,1,2,3,c]", function( _r ) { return _r.toString(); } );
	
	_test_method( ["filter", "c" ],"[c,c]", function( _r ) { return _r.toString(); } );
	_test_method( ["filter", "c", function( _a, _b ) { return _a != _b; } ],"[1,2,3]", function( _r ) { return _r.toString(); } );
	
	_test_method( "clear","[]" );
	
	var _ta	= [];
	repeat( 10 ) {
		var _char	= chr(ord( "A" ) + irandom( 0xF ));
		array_push( _ta, _char );
		__iter.push( _char );
		
	}
	array_sort( _ta, true );
	
	var _str = "[";
	var _i = 0; repeat( array_length( _ta ) ) {
		if ( _str != "[" ) { _str += ","; }
		_str	+= _ta[ _i++ ];
	}
	_str	+= "]";
	
	_test_method( "sort", _str, function( _r ) { return _r.toString(); } );
	
// # END TEST BODY
	if ( _methods != array_length( __tests ) ) {
		syslog( "Warning! Only ", array_length( __tests ), " of ", _methods, " tested." );
		
	}
	
}