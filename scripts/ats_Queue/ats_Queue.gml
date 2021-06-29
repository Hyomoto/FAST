function ats_Queue( _type ){
	_type = _type == undefined ? HashMap : _type;
// # TOTAL METHODS LOOKING TO TEST
	var _methods	= [ "push", "pop", "peek", "is_empty", "size" ];
	
// # Set test source
	test( new Queue() );
	
// # Test errors
	
	
// # TEST METHODS
	test_method( ["is_empty" ], True, __returns );
	test_method( ["pop"], __source.EOQ, __returns );
	
	
	repeat( 1 ) {
		var _i = 0, _a = undefined, _b = undefined, _str = "";
		
		repeat( 2 + irandom( 50 )) { ++_i;
			if ( _str != "" ) { _str += ","; }
			var _d	= irandom( 0xFF );
			if ( _a == undefined ) { _a = _d; }
			else if ( _b == undefined ) { _b = _d; }
			
			_str	+= string( _d );
			
			test_method( ["push", _d ], _i, function() { return __source.size() });
			
		}
		test_method( "toString", "[ " + _str + " ]" );
		test_method( ["pop"], _a, __returns );
		test_method( ["peek"], _b, __returns );
		test_method( ["is_empty" ], False, __returns );
		
		repeat( __source.size() ) {
			__source.pop();
			
		}
		test_method( ["is_empty" ], True, __returns );
		
	}
	test_method( ["pop"], __source.EOQ, __returns );
	test_method( ["size"], 0, __returns );
	
// # END TEST BODY
	return _methods;
	
}