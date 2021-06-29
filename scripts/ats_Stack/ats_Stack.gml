function ats_Stack( _type ){
	_type = _type == undefined ? HashMap : _type;
// # TOTAL METHODS LOOKING TO TEST
	var _methods	= [ "push", "pop", "peek", "is_empty", "size" ];
	
// # Set test source
	test( new Stack() );
	
// # Test errors
	
	
// # TEST METHODS
	test_method( ["is_empty" ], True, __returns );
	test_method( ["pop"], __source.EOS, __returns );
	
	repeat( 10 ) {
		var _a	= irandom( 100 );
		var _b	= irandom( 100 );
		
		test_method( ["push", _a, _b ], "[ " + string( _b ) + "," + string( _a ) + " ]" );
		test_method( ["size"], 2, __returns );
		test_method( ["pop"], _b, __returns );
		test_method( ["peek"], _a, __returns );
		test_method( ["is_empty" ], False, __returns );
		test_method( ["size"], 1, __returns );
		test_method( ["pop"], _a, __returns );
		
	}
	test_method( ["pop"], __source.EOS, __returns );
	test_method( ["size"], 0, __returns );
	
// # END TEST BODY
	return _methods;
	
}