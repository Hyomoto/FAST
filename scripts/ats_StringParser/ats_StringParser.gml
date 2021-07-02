function ats_StringParser() {
// # TOTAL METHODS LOOKING TO TEST
	var _methods	= [
		"open",
		"close",
		//"restart",
		"finished",
		"read",
		"remaining",
		"peek",
		"load",
		"save",
		"to_array",
		//"size",
		"toString"
	];
	
// # Set test source
	var _text	= "The quick brown fox jumped over the lazy dog.";
	var _test	= string_explode( _text, " " );
	
	test( new StringParser() );
	
	//test_method( "size", 0, __returns );
	test_method( ["open", _text ], _text );
	//test_method( "size", 45, __returns );
	test_method( "toString", _text, __returns );
	
	test_method( "finished", False, __returns );
	
	var _i = 0; while ( __source.finished() == false ) {
		test_method( "peek", _test[ _i ], __returns );
		test_method( "read", _test[ _i++ ], __returns );
		var _last	= __source.__Last;
		if ( __source.finished() ) {
			test_method( "remaining", __source.END, __returns );
			
		} else {
			test_method( [ "toString", true ], string_delete( _text, 1, __source.__Last - 1 ), __returns );
			test_method( "remaining", string_delete( _text, 1, __source.__Last - 1 ), __returns );
			
		}
		__source.__Last = _last;
	}
	test_method( "peek", __source.END, __returns );
	test_method( "read", __source.END, __returns );
	
	//test_method( "restart", _text );
	//test_method( "remaining", _text, __returns );
	
	var _save	= __source.save();
	log_test( "save" );
	
	test_method( ["close", _text ], "" );
	
	test_method( [ "load", _save ], _text );
	
	test_method( "to_array", ["The", "quick", "brown", "fox", "jumped", "over", "the", "lazy", "dog."], __returns );
	
// # END TEST BODY
	return _methods;
	
}