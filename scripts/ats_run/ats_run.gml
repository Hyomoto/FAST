/// @func ats_run
/// @param tags...
/// @desc	Runs the ATS on all script resources with the given tags.  If no TAG is specified, ATS is
///		assumed.
function ats_run() {
	var _ats = new( function() constructor {
		static test	= function( _script ) {
			__test_failures	= 0;
			__tests			= [];
			
			syslog( script_get_name( _script ) );
			
			_script();
			
		}
		static to_func	= function( _a ) {
			var _i = 1, _m = _a[ 0 ] + "("; repeat( array_length( _a ) - _i ) {
				if ( _i > 1 ) { _m += ", "; }
				_m	+= string( _a[ _i++ ] );
				
			}
			return _m + ")";
			
		}
		static do_method	= function( _a ) {
			if ( is_array( _a ) == false ) { _a = [ _a ]; }
			
			if ( __verbose ) {
				syslog( "  running " + to_func( _a ) );
				
			}
			try {
				var _f = method( __iter, __iter[$ _a[ 0 ] ] )
				
			} catch ( _ ) {
				syslog( "Warning! Method " + string( _a[ 0 ] ) + " not found." );
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
		static log_method	= function( _test ) {
			var _i = 0; repeat( array_length( __tests ) ) {
				if ( __tests[ _i++ ] == _test ) { return; }
				
			}
			array_push( __tests, _test );
			
		}
		__tests			= undefined;
		__verbose		= false;
		
	})();
	
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
	
	syslog( "#### STARTING TEST #####" );
	
	var _i = 0; repeat( array_length( _list ) ) {
		_ats.test( _list[ _i++ ] );
		_error	+= _ats.__test_failures;
		
	}
	syslog( "##### TEST COMPLETED #####" );
	syslog( "Total Tests: " + string( _i ) );
	syslog( "Total Errors: " + string( _error ) );
	
}
