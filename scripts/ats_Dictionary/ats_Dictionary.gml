function ats_Dictionary(){
// # TOTAL METHODS LOOKING TO TEST
	var _methods	= ats_HashMap( Dictionary );
	
	_methods	= array_union( _methods, [ "search", "peek", "poke", "first", "last", "next", "previous" ] );
	
	var _words	= [ 
		"annoy",
		"possible",
		"enormous",
		"powder",
		"peace",
		"burst",
		"rot",
		"spectacular",
		"abundant",
		"listen",
		"frog",
		"cheat",
		"books",
		"capable",
		"rhyme",
		"slope",
		"file",
		"future",
		"price",
		"ticket"
	];
	test( new Dictionary() );
	
	var _i = -1; repeat( array_length( _words ) ) { ++_i; __source.set( _words[ _i ], _i ); }
	
	test_method( "last", "ticket", __returns );
	test_method( "first", "abundant", __returns );
	
	array_sort( _words, true );
	
	var _i = 1; repeat( __source.size() - 1 ) { test_method( "next", _words[ _i++ ], __returns ); }
	--_i; repeat( __source.size() - 1 ) { test_method( "previous", _words[ --_i ], __returns ); }
	
	test_method( [ "search", "a" ], "abundant", __returns );
	test_method( [ "search", "b" ], "books", __returns );
	test_method( [ "search", "c" ], "capable", __returns );
	test_method( [ "search", "cal" ], "capable", __returns );
	
	test_method( "next", "cheat", __returns );
	
	test_method( [ "search", "caq" ], "cheat", __returns );
	test_method( [ "search", "cha" ], "cheat", __returns );
	
	test_method( [ "search", "z" ], "ticket", __returns );
	
	test_method( "previous", "spectacular", __returns );
	
	test_method( [ "unset", "burst" ], "capable", function ( _r ) { return __source.search( "burst" ); });
	
	repeat( __source.size() ) { __source.unset( __source.search( "a" ) ); }
	
	test_method( "size", 0, __returns );
	
	test_method( ["from_JSON", "{ \"foo\": 10, \"bar\": 20 }" ], "[bar,foo]", function ( _r ) { return __source.__Keys.toString() } );
	
	test_method( "peek", ValueNotFound, function( _r ) { return error_type( _r ); });
	__source.first();
	
	test_method( "peek", 20, __returns );
	__source.poke( 40 );
	log_test( "poke" );
	
	test_method( "peek", 40, __returns );
	__source.next();
	
	test_method( "peek", 10, __returns );
	__source.next();
	
	test_method( "peek", ValueNotFound, function( _r ) { return error_type( _r ); } );
	
	//[ "abundant","annoy","books","burst","capable","cheat","enormous","file","frog","future","listen","peace","possible","powder","price","rhyme","rot","slope","spectacular","ticket" ]
// # END TEST BODY
	return _methods;
	
}
