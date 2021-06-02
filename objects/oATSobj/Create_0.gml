__run	= function() {
	var _list;
	
	if ( argument_count == 0 || is_string( argument[ 0 ] ) ) {
		var _tags = argument_count == 0 ? ["ATS"] : argument_count;
		var _i = 0; repeat( argument_count ) { _tags[ _i ]	= argument[ _i ]; ++_i; }
		
		_list	= tag_get_asset_ids(_tags, asset_script);
		
	} else {
		_list	= array_create( argument_count );
		var _i = 0; repeat( argument_count ) { _list[ _i ] = argument[ _i ]; ++_i; }
		
	}
	var _error	= 0;
	
	print( "#### STARTING TEST #####" );
	
	var _i = 0; repeat( array_length( _list ) ) {
		__test_start( _list[ _i++ ] );
		_error	+= __test_failures;
		
	}
	print( "##### TEST COMPLETED #####" );
	print( "Total Tests:    " + string( _i ) );
	print( "Total Errors:   " + string( _error ) );
	print( "Total Warnings: " + string( __warnings ) );
	
}
__test_start	= function( _script ) {
	__test_failures	= 0;
	__tests			= [];
// # Write test
	print( ">> ", script_get_name( _script ), " <<" );
// # Perform test
	var _methods	= _script();
// # Check for completeness
	var _diff		= array_difference( _methods, __tests );
// # Display warning if tests are not performed
	if ( array_length( _diff ) > 0 ) {
		print( "\t", "Warning! ", array_length( _diff ), " tests were not performed." );
		
		var _i = 0, _m = ""; repeat( array_length( _diff ) ) {
			if ( _m != "" ) { _m += ", "; }
			_m += _diff[ _i++ ];
			
		}
		print( "\t\t", _m );
		++__warnings;
				
	}
			
}
test	= function( _thing ) {
	__source	= _thing;
			
}
test_method	= function( _a, _b, _c ) {
	if ( is_array( _a ) == false ) { _a = [ _a ]; }
	if ( _c == undefined ) { _c = function( _r ) { return __source.toString(); } }
			
	try {
		assert_equal( _c( do_method( _a ) ), _b, "FAIL: Method " + to_func( _a ) + " failed." )
	} catch ( _ex ) {
		assert_equal( instanceof( _ex ), _b, "FAIL: Method " + to_func( _a ) + " generated an error!" );
				
	}
	log_method( _a[ 0 ] );
			
}
test_throwable	= function( _a, _b ) {
	try {
		do_method( _a );
				
	} catch( _ex ) {
		assert_equal( instanceof( _ex ), script_get_name( _b ), "FAIL: Method " + to_func( _a ) + " threw wrong error.\n" + _ex.message );
		return;
	}
	assert_equal( "no throwable", script_get_name( _b ), "FAIL: Method " + to_func( _a ) + " did not throw an error." );
			
}
test_func	= function( _a, _b, _c ) {
	assert( _c( _a, _b ), "Method " + _a + "() failed." )
			
}
__returns	= function( _r ) { return _r; }
to_func	= function( _a ) {
	var _i = 1, _m = _a[ 0 ] + "("; repeat( array_length( _a ) - _i ) {
		if ( _i > 1 ) { _m += ", "; }
		_m	+= string( _a[ _i++ ] );
				
	}
	return _m + ")";
			
}
do_method	= function( _a ) {
	if ( is_array( _a ) == false ) { _a = [ _a ]; }
			
	if ( __verbose ) {
		print( "  running " + to_func( _a ) );
				
	}
	try {
		var _f = method( __source, __source[$ _a[ 0 ] ] )
				
	} catch ( _ ) {
		print( "Warning! Method " + string( _a[ 0 ] ) + " not found." );
		throw new ValueNotFound( "do_method", _a[ 0 ] );
				
	}
	switch ( array_length( _a ) ) {
		case 1 : return _f(); break;
		case 2 : return _f( _a[ 1 ] );
		case 3 : return _f( _a[ 1 ], _a[ 2 ] );
		case 4 : return _f( _a[ 1 ], _a[ 2 ], _a[ 3 ] );
		case 5 : return _f( _a[ 1 ], _a[ 2 ], _a[ 3 ], _a[ 4 ] );
		case 6 : return _f( _a[ 1 ], _a[ 2 ], _a[ 3 ], _a[ 4 ], _a[ 5 ] );
		case 7 : return _f( _a[ 1 ], _a[ 2 ], _a[ 3 ], _a[ 4 ], _a[ 5 ], _a[ 6 ] );
		case 8 : return _f( _a[ 1 ], _a[ 2 ], _a[ 3 ], _a[ 4 ], _a[ 5 ], _a[ 6 ], _a[ 7 ] );
		case 9 : return _f( _a[ 1 ], _a[ 2 ], _a[ 3 ], _a[ 4 ], _a[ 5 ], _a[ 6 ], _a[ 7 ], _a[ 8 ] );
	}
	
}
log_method	= function( _test ) {
	var _i = 0; repeat( array_length( __tests ) ) {
		if ( __tests[ _i++ ] == _test ) { return; }
				
	}
	array_push( __tests, _test );
			
}
__tests			= undefined;
__warnings		= 0;
__verbose		= false;
		
print	= function() {
	var _i = 0, _m = ""; repeat( argument_count ) {
		_m	+= string( argument[ _i++ ] );
		
	}
	repeat( string_count( "\n", _m ) + 1 ) {
		var _g	= string_pos( "\n", _m );
		
		if ( _g == 0 ) {
			array_push( list, _m );
			
		} else {
			array_push( list, string_copy( _m, 1, _g - 1 ) );
			_m	= string_delete( _m, 1, _g );
			
		}
		
	}
	
}
surface	= new Surface();
list	= [];
bufferW	= 8;
bufferH	= 3;
lines	= 0;
start	= 0;
depth	= -1;

#macro ATS_TESTING_ENABLED			false
#macro Testing:ATS_TESTING_ENABLED	true

#macro True		bool(true)
#macro False	bool(false)

gml_pragma( "global", "if ( ATS_TESTING_ENABLED ) { room_instance_add( room_first, 0, 0, oATSobj ); }" );
