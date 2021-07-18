// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ats_f_arrays(){
	var _test	= [
		"array_binary_search",
		"array_combine",
		"array_difference",
		"array_insertion_sort",
		"array_merge_sort",
		"array_quicksort",
		"array_reverse",
		"array_shuffle",
		"array_simple_search",
		"array_swap",
		"array_to_string",
		"array_union",
		"array_unique"
	]
	var _array	= function() { return [23,7,10,44,97] };
	
	test( _array() );
	test_function( [ "array_quicksort", __source ], "[ 7,10,23,44,97 ]" );
	test_throwable( [ "array_quicksort", "a" ], InvalidArgumentType, do_function );
	test_throwable( [ "array_quicksort", [ 0,1,2 ], "a" ], InvalidArgumentType, do_function );
	
	test( _array() );
	test_function( [ "array_merge_sort", __source ], "[ 7,10,23,44,97 ]" );
	test_throwable( [ "array_merge_sort", "a" ], InvalidArgumentType, do_function );
	test_throwable( [ "array_merge_sort", [ 0,1,2 ], "a" ], InvalidArgumentType, do_function );
	
	test( _array() );
	test_function( [ "array_insertion_sort", __source ], "[ 7,10,23,44,97 ]" );
	test_throwable( [ "array_insertion_sort", "a" ], InvalidArgumentType, do_function );
	test_throwable( [ "array_insertion_sort", [0,1,2], "a" ], InvalidArgumentType, do_function );
	
	test_function( [ "array_to_string", __source ], "[ 7,10,23,44,97 ]" );
	test_throwable( [ "array_to_string", "a" ], InvalidArgumentType, do_function );
	test_throwable( [ "array_to_string", [], 0 ], InvalidArgumentType, do_function );
	
	test_function( [ "array_binary_search", __source, 0 ], ValueNotFound , __returnError );
	test_function( [ "array_binary_search", __source, 23 ], 2, __returns );
	test_function( [ "array_binary_search", __source, 97 ], 4, __returns );
	test_function( [ "array_binary_search", __source, 7 ], 0, __returns );
	test_throwable( [ "array_binary_search", "a" ], InvalidArgumentType, do_function );
	test_throwable( [ "array_binary_search", [], 0, 0 ], InvalidArgumentType, do_function );
	
	test_function( [ "array_simple_search", __source, 0 ], ValueNotFound , __returnError );
	test_function( [ "array_simple_search", __source, 23 ], 2, __returns );
	test_throwable( [ "array_simple_search", "a" ], InvalidArgumentType, do_function );
	test_throwable( [ "array_simple_search", [], 0, 0 ], InvalidArgumentType, do_function );
	
	test_function( [ "array_reverse", __source ], "[ 97,44,23,10,7 ]" );
	test_throwable( [ "array_reverse", "a" ], InvalidArgumentType, do_function );
	
	repeat( 100 ) {
		var _size	= array_length( __source ) - 1;
		var _comp	= string( __source );
		do {
			var _a	= irandom( _size );
			var _b	= irandom( _size );
			
		} until ( _a != _b );
		
		test_function( [ "array_swap", __source, _a, _b ], _comp, undefined, "assert_not_equal" );
		
	}
	assert_equal( array_sort( __source, true ), array_sort( _array(), true ), "FAIL: array_swap failed, contents changed!" ); 
	
	var _rarr	= array_create( 100 ); var _i = 0; repeat( array_length( _rarr ) ) { _rarr[ _i++ ] = irandom( 100 ); }
	var _tarr	= []; array_copy( _tarr, 0, _rarr, 0, array_length( _rarr ) );
	
	repeat( 100 ) {
		var _comp	= string( _tarr );
		
		test_function( [ "array_shuffle", _tarr ], _comp, undefined, "assert_not_equal" );
		
	}
	assert_equal( array_sort( _tarr, true ), array_sort( _rarr, true ), "FAIL: array_shuffle failed, contents changed!" ); 
	
	test_function( [ "array_combine", [ 0, 1 ], [ 2, 3 ] ], [ 0, 1, 2, 3 ], __returns );
	test_throwable( [ "array_combine", "a" ], InvalidArgumentType, do_function );
	
	test_function( [ "array_union", [ 0, 1, 2 ], [ 1, 2, 3 ] ], [ 0, 1, 2, 3 ], function ( _r ) { array_sort( _r, true ); return _r } );
	test_throwable( [ "array_union", "a" ], InvalidArgumentType, do_function );
	test_throwable( [ "array_union", [], "a" ], InvalidArgumentType, do_function );
	
	test_function( [ "array_intersection", [ 0, 1, 2 ], [ 1, 2, 3 ] ], [ 1, 2 ], function ( _r ) { array_sort( _r, true ); return _r } );
	test_throwable( [ "array_intersection", "a" ], InvalidArgumentType, do_function );
	test_throwable( [ "array_intersection", [], "a" ], InvalidArgumentType, do_function );
	
	test_function( [ "array_difference", [ 0, 1, 2 ], [ 1, 2, 3 ] ], [ 0 ], function ( _r ) { array_sort( _r, true ); return _r } );
	test_throwable( [ "array_difference", "a" ], InvalidArgumentType, do_function );
	test_throwable( [ "array_difference", [], "a" ], InvalidArgumentType, do_function );
	
	test_function( [ "array_unique", [ 0, 1, 0, 1, 2, 1, 0, 2, 2, 2, 3, 2 ] ], [ 0,1,2,3 ], function ( _r ) { array_sort( _r, true ); return _r } );
	
	return _test;
	
}
