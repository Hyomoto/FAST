function ats_Parser() {
// # TOTAL METHODS LOOKING TO TEST
	var _methods	= [
		"open",
		"close",
		"finished",
		"read",
		"word",
		"remaining",
		"advance",
		"mark",
		"unmark",
		"reset",
		"unread",
		"pop",
		"push",
		"skip",
		"peek",
		"to_array",
		"count",
		"toString"
	];
	
// # Set test source
	var _text	= "The quick brown fox jumped over the lazy dog.";
	var _test	= string_explode( _text, " " );
	
	test( new Parser() );
	
	test_method( ["count", char_is_whitespace, false ], 0, __returns );
	test_method( ["open", _text ], _text );
	test_method( ["count", char_is_whitespace, false ], 9, __returns );
	//test_method( "size", 45, __returns );
	test_method( "toString", _text, __returns );
	test_method( "finished", False, __returns );
	
	test_method( "mark", _text );
	
	var _i = 1; while ( __source.finished() == false ) {
		test_method( "peek", string_char_at( _text, _i ), __returns );
		test_method( "read", string_char_at( _text, _i++ ), __returns );
		
	}
	test_method( "reset", _text );
	var _i = 0; while ( __source.finished() == false ) {
		test_method( ["word", char_is_whitespace, false ], _test[ _i++ ], __returns );
		__source.mark();
		if ( __source.finished() ) {
			test_method( "remaining", "", __returns );
			
		} else {
			test_method( "remaining", string_delete( _text, 1, __source.__Index ), __returns );
			
		}
		__source.reset();
	}
	log_test( "advance", "unmark", "unread", "skip", "reset" );
	//test_method( "peek", __source.END, __returns );K
	test_method( "read", __source.END, __returns );
	
	var _last	= __source.__Index;
	
	test_method( "push", 1, function() { return __source.__State.size() });
	
	test_method( "reset", 0, function() { return __source.__Index });
	
	test_method( [ "pop" ], _last, function() { return __source.__Index });
	
	test_method( "to_array", ["The", "quick", "brown", "fox", "jumped", "over", "the", "lazy", "dog."], __returns );
	
	test_method( "close", _text, __returns );
	
// # END TEST BODY
	return _methods;
	
}