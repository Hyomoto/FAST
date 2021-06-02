// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ats_IterableList( _type ){
// # TOTAL METHODS LOOKING TO TEST
	var _methods	= [ "index", "next", "push", "insert", "replace", "swap", "pop", "clear", "size", "remove", "count", "filter", "sort", "unique", "reverse", "find", "contains", "copy", "is_empty", "allow_duplicates", "from_array", "to_array", "from_JSON", "to_JSON" ];
	
// # Set test source
	test( new _type() );
	
// # Test errors
	test_throwable( ["insert",4,"a"], IndexOutOfBounds );
	test_throwable( ["filter", "bob", "a"], InvalidArgumentType );
	test_throwable( ["remove", "d"], ValueNotFound );
	test_throwable( ["from_JSON", 0], InvalidArgumentType );
	test_throwable( ["from_JSON", "d"], BadJSONFormat );
	test_throwable( ["from_JSON", "{}"], UnexpectedTypeMismatch );
	
// # TEST METHODS
	test_method( [ "from_JSON", "[ \"a\", \"b\", \"c\" ]" ], "[a,b,c]" );
	
	test_method( "size", 3, __returns);
	
	test_method( "is_empty", bool( false ), __returns );
	
	test_method( "to_JSON", "[ \"a\", \"b\", \"c\" ]", __returns );
	
	test_method( "to_array", ["a","b","c"], __returns );
	
	test_method( ["from_array", ["a", "b", "c" ]], "[a,b,c]" );
	
	test_method( ["index",0], "a", __returns );
	
	test_method( ["next"], "a", __returns );
	test_method( ["next"], "b", __returns );
	test_method( ["next"], "c", __returns );
	test_method( ["next"], __source.EOL, __returns );
	
	test_method( ["remove","b"],"[a,c]" );
	
	test_method( ["index",1], "c", __returns );
	
	test_method( ["insert",2,"a"],"[a,c,a]" );
	
	test_method( ["pop",0],"[c,a]" );
	
	test_method( "pop","[c]" );
	
	__source.remove_duplicates();
	array_push( __tests, "allow_duplicates" );
	
	test_method( ["push", "c", "c"], "[c]" );
	
	__source.remove_duplicates( false );
	
	test_method( ["push","1","2","3","c"],"[c,1,2,3,c]" );
	
	test_method( "reverse","[c,3,2,1,c]", function( _r ) { return _r.toString(); } );
	
	test_method( ["contains", "c", "3", "1", "3" ], true, __returns );
	
	test_method( ["find", "c" ], 0, __returns );
	test_method( ["find", "1" ], 1, __returns );
	test_method( ["find", "2" ], 2, __returns );
	test_method( ["find", "3" ], 3, __returns );
	
	test_method( ["count", "c" ], 2, __returns );
	
	test_method( ["contains", "b" ], false, __returns );
	
	test_method( "unique", "[1,2,3,c]", function( _r ) { return _r.toString(); } );
	
	test_method( ["copy"],"[c,1,2,3,c]", function( _r ) { return _r.toString(); } );
	
	test_method( ["filter", "c" ],"[c,c]", function( _r ) { return _r.toString(); } );
	test_method( ["filter", "c", function( _a, _b ) { return _a != _b; } ],"[1,2,3]", function( _r ) { return _r.toString(); } );
	
	test_method( ["replace", 2, "dog" ], "[c,1,dog,3,c]" );
	
	test_method( ["swap", 1, 3 ], "[c,3,dog,1,c]" );
	
	test_method( "clear","[]" );
	
	var _ta	= [];
	repeat( 10 ) {
		var _char	= chr(ord( "A" ) + irandom( 0xF ));
		array_push( _ta, _char );
		__source.push( _char );
		
	}
	array_sort( _ta, true );
	
	var _str = "[";
	var _i = 0; repeat( array_length( _ta ) ) {
		if ( _str != "[" ) { _str += ","; }
		_str	+= _ta[ _i++ ];
	}
	_str	+= "]";
	
	test_method( "sort", _str, function( _r ) { return _r.toString(); } );
	
// # END TEST BODY
	return _methods;
	
}
