// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ats_f_numbers(){
	var _test	= [
		"int_overflow",
	]
	//var _array	= function() { return [23,7,10,44,97] };
	
	test_throwable( [ "int_overflow", "a" ], InvalidArgumentType, do_function );
	test_throwable( [ "int_overflow", 0, "a" ], InvalidArgumentType, do_function );
	test_throwable( [ "int_overflow", 0, 0, "a" ], InvalidArgumentType, do_function );
	
	test_function( [ "int_overflow", 10, 255 ], 10, __returns );
	test_function( [ "int_overflow", 265, 255 ], 10, __returns );
	test_function( [ "int_overflow", 265, -255, 255 ], -245, __returns );
	
	return _test;
	
}
