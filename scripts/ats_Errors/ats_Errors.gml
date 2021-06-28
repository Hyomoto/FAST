function ats_Errors() {
	var _test	= [
		//"IndexOutOfBounds",
		//"ValueNotFound",
		//"InvalidArgumentType",
		//"UnexpectedTypeMismatch",
		//"BadJSONFormat",
		"error_type"
	];
	test( new __Error__() );
	
	__source.message	= "test";
	
	test_method( ["c", "a", "b", "c" ], "abc", __returns );
	test_method( ["toString" ], "\n\n\n__Error__ :: test\n\n", __returns );
	test_function( ["error_type", __source ], __Error__, __returns );
	
	return _test;
	
}
