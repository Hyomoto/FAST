function ats_f_strings() {
	var _test	= [
		"string_combine",
		"string_explode",
		"string_find_first",
		"string_from_time",
		"string_pad",
		"string_to_real",
		"string_trim",
		"string_formatted"
	]
	test_function( [ "string_combine", "a", "b", "c" ], "abc", __returns );
	
	test_function( [ "string_explode", "a b c", " " ], ["a","b","c"], __returns );
	test_throwable( [ "string_explode", 9 ], InvalidArgumentType, do_function );
	test_throwable( [ "string_explode", "a", 0 ], InvalidArgumentType, do_function );
	test_throwable( [ "string_explode", "a", "a", "a" ], InvalidArgumentType, do_function );
	
	test_function( [ "string_find_first", "abc", "the cat broke the vase" ], 5, __returns );
	test_throwable( [ "string_find_first", 9 ], InvalidArgumentType, do_function );
	test_throwable( [ "string_find_first", "a", 0 ], InvalidArgumentType, do_function );
	test_throwable( [ "string_find_first", "a", "a", "a" ], InvalidArgumentType, do_function );
	test_throwable( [ "string_find_first", "a", "a", -1 ], IndexOutOfBounds, do_function );
	test_throwable( [ "string_find_first", "a", "a", 2 ], IndexOutOfBounds, do_function );
	
	test_function( [ "string_from_time", 2410623, "$H hours $M.MM minutes" ], "669 hours 37.05 minutes", __returns );
	test_throwable( [ "string_from_time", "a" ], InvalidArgumentType, do_function );
	test_throwable( [ "string_from_time", 9, 9 ], InvalidArgumentType, do_function );
	
	test_function( [ "string_pad", "8125", 6, true, "0" ], "008125", __returns );
	test_throwable( [ "string_pad", 9 ], InvalidArgumentType, do_function );
	test_throwable( [ "string_pad", "a", 0 ], InvalidArgumentType, do_function );
	test_throwable( [ "string_pad", "a", "a", "a" ], InvalidArgumentType, do_function );
	
	test_function( [ "string_to_real", "0xFF" ], 255, __returns );
	test_function( [ "string_to_real", "255" ], 255, __returns );
	test_throwable( [ "string_to_real", 9 ], InvalidArgumentType, do_function );
	test_throwable( [ "string_to_real", "apple" ], BadValueFormat, do_function );
	
	test_function( [ "string_formatted", "{}{}{}", "a", "b", "c" ], "abc", __returns );
	test_function( [ "string_formatted", "{} {} {}", "a", "b", "c" ], "a b c", __returns );
	test_function( [ "string_formatted", "{} {} {}", "a", "b" ], "a b {}", __returns );
	
	test_function( [ "string_trim", "\t white space! \t\t\t     " ], "white space!", __returns );
	test_throwable( [ "string_pad", 9 ], InvalidArgumentType, do_function );
	test_throwable( [ "string_pad", "a", 0 ], InvalidArgumentType, do_function );
	
	return _test;
	
}