__run	= function() {
	if ( running == undefined ) {
		var _list;
		
		if ( argument_count == 0 || is_string( argument[ 0 ] ) ) {
			var _tags = argument_count == 0 ? ["ATS"] : argument_count;
			var _i = 0; repeat( argument_count ) { _tags[ _i ]	= argument[ _i ]; ++_i; }
			
			_list	= tag_get_asset_ids(_tags, asset_script);
			
		} else {
			_list	= array_create( argument_count );
			var _i = 0; repeat( argument_count ) { _list[ _i ] = argument[ _i ]; ++_i; }
			
		}
		print( "#### STARTING TEST #####" );
		
		running = {
			list	: _list,
			errors	: 0,
			timer	: new Timer(),
			index	: 0,
			tested	: 0
		}
		timer.reset();
		
	}
	
}
__test_start	= function( _script ) {
	__test_failures	= 0;
	__tests			= [];
// # Write test
	print( ">> ", script_get_name( _script ), " <<" );
	syslog( ">> ", script_get_name( _script ), " <<" );
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
test_method	= function( _a, _b, _c, _d ) {
	running.tested++
	if ( is_array( _a ) == false ) { _a = [ _a ]; }
	if ( _c == undefined ) { _c = function( _r ) { return __source[$ "toString" ] != undefined ? __source.toString() : string( __source ); } }
	
	_d	= asset_get_index( _d == undefined ? "assert_equal" : _d );
	
	try {
		_d( _c( do_method( _a ) ), _b, "FAIL: Method " + to_func( _a ) + " failed." )
	} catch ( _ex ) {
		_d( instanceof( _ex ), _b, "FAIL: Method " + to_func( _a ) + " generated an error!" );
		if ( _ex.longMessage == "" ) {
			syslog( _ex.message );
		} else {
			syslog( _ex.longMessage );}
	}
	log_test( _a[ 0 ] );
	
}
test_function	= function( _a, _b, _c, _d ) {
	running.tested++
	if ( is_array( _a ) == false ) { _a = [ _a ]; }
	if ( _c == undefined ) { _c = function( _r ) { return is_struct( __source ) && __source[$ "toString" ] != undefined ? __source.toString() : string( __source ); } }
	
	_d	= asset_get_index( _d == undefined ? "assert_equal" : _d );
	
	try {
		_d( _c( do_function( _a ) ), _b, "FAIL: Function " + to_func( _a ) + " failed." )
	} catch ( _ex ) {
		_d( instanceof( _ex ), _b, "FAIL: Function " + to_func( _a ) + " generated an error!" );
		if ( _ex.longMessage == "" ) {
			syslog( _ex.message );
		} else {
			syslog( _ex.longMessage );}
	}
	log_test( _a[ 0 ] );
	
}
test_throwable	= function( _a, _b, _c ) {
	running.tested++
	try {
		if ( _c != undefined ) { _c( _a ); } else { do_method( _a ); }
		
	} catch( _ex ) {
		assert_equal( instanceof( _ex ), script_get_name( _b ), "FAIL: Throwable " + to_func( _a ) + " threw wrong error.\n" + _ex.message );
		if ( instanceof( _ex ) != script_get_name( _b ) )
			show_debug_message( _ex.longMessage );
		return;
	}
	assert_equal( "no throwable", script_get_name( _b ), "FAIL: Throwable " + to_func( _a ) + " did not throw an error." );
	
}
__returns		= function( _r ) { return _r; }
__returnError	= function( _r ) { return error_type( _r ); }
__toString		= function( _r ) { return _r.toString() }

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
do_function	= function( _a ) {
	if ( is_array( _a ) == false ) { _a = [ _a ]; }
	
	var _f	= asset_get_index( _a[ 0 ] );
	
	if ( __verbose ) {
		print( "  running " + to_func( _a ) );
		
	}
	if ( _a[ 0 ] == -1 ) {
		print( "Warning! Function " + string( _a[ 0 ] ) + " not found." );
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
log_test	= function( _test ) {
	var _j = 0; repeat( argument_count ) {
		var _i = 0; repeat( array_length( __tests ) ) {
			if ( __tests[ _i++ ] == argument[ _j ] ) { break; }
			
		}
		if ( _i == 0 || __tests[ _i - 1 ] != argument[ _j ] )
			array_push( __tests, argument[ _j ] );
		++_j;
	}
			
}
__tests			= undefined;
__warnings		= 0;
__verbose		= false;

sleep	= function( _v ) {
	waitFor	= _v;
	
}
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
	surface.redraw();
	
}
surface	= new Surface();
list	= [];
bufferW	= 8;
bufferH	= 3;
lines	= 0;
start	= 0;
depth	= -1;
running	= undefined;
stepSpeed	= 100000;
waitFor		= 0;
timer	= new Timer();

#macro ATS_TESTING_ENABLED			false
#macro Testing:ATS_TESTING_ENABLED	true

#macro True		bool(true)
#macro False	bool(false)

gml_pragma( "global", "if ( ATS_TESTING_ENABLED ) { room_instance_add( room_first, 0, 0, oATSobj ); }" );
