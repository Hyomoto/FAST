function ats_Dictionary(){
// # TOTAL METHODS LOOKING TO TEST
	var _methods	= [ "set", "unset", "lookup", "lookup_by_array", "key_exists", "size", "keys_to_array", "from_JSON", "to_JSON" ];
	
// # Set test source
	test( new Dictionary() );
	
// # Test errors
	test_throwable( ["set", 4, "a"], InvalidArgumentType );
	test_throwable( ["unset", 4 ], InvalidArgumentType );
	test_throwable( ["unset", "a" ], ValueNotFound );
	test_throwable( ["lookup", 4 ], InvalidArgumentType );
	test_throwable( ["lookup", "a" ], ValueNotFound );
	test_throwable( ["lookup_by_array", "a" ], InvalidArgumentType );
	test_throwable( ["key_exists", 0 ], InvalidArgumentType );
	
	test_throwable( ["from_JSON", 0], InvalidArgumentType );
	test_throwable( ["from_JSON", "d"], BadJSONFormat );
	test_throwable( ["from_JSON", "[]"], UnexpectedTypeMismatch );
	
// # TEST METHODS
	test_method( ["is_empty" ], bool( true ), __returns );
	
	test_method( ["set", "foo", "bar"], "bar", function ( _r ) { return _r.__Content[$ "foo" ] } );
	
	test_method( ["lookup", "foo" ], "bar", __returns );
	
	test_method( ["unset", "foo" ], undefined, function( _r ) { return _r.__Content[$ "foo" ] } );
	
	test_method( ["from_JSON", "{ \"foo\": 10, \"bar\": 20 }" ], 20, function ( _r ) { return _r.__Content[$ "bar" ] } );
	
	test_method( ["to_JSON" ], "{ \"foo\": 10.0, \"bar\": 20.0 }", __returns );
	
	test_method( ["key_exists", "foo"], bool( true ), __returns );
	
	test_method( ["size"], 2, __returns );
	
	test_method( ["keys_to_array"], ["foo","bar"], __returns );
	
	test_method( ["lookup_by_array", ["bar","foo"] ], [20,10], __returns );
	
// # END TEST BODY
	return _methods;
	
}