/// @func StringFormatter
/// @param format
/// @param *functions
function StringFormatter( _format, _functions ) constructor {
	// processes the format into a set of rules the formatter can then use
	static rules	= function( _string ) {
		if ( _string == "" ) { return; }
		
		var _rules	= string_explode( _string, ",", false );
		var _rule, _flags, _func;
		
		var _i = 0; repeat( array_length( _rules ) ) {
			_rule	= string_explode( _rules[ _i++ ], ":", false );
			_flags	= string_explode( _rule[ 1 ], "+", false );
			
			var _u = 0; repeat( array_length( _flags ) ) {
				var _func	= variable_struct_get( functions, _flags[ _u ] )
				
				_flags[ _u++ ]	= ( _func == undefined ? function() {} : method( self, _func ) );
				
			}
			ruleset[? _rule[ 0 ] ]	= [ _rule[ 1 ], _flags ];
			
			keys	= keys + _rule[ 0 ];
			
		}
		
	}
	// takes the input, applies the ruleset
	static format	= function( _input ) {//, _output, _params ) {
		var _ruleset, _raw, _func;
		
		_input	= { value : _input }
		
		setup( _input );
		last	= 0;
		
		while( true ) {
			last	= string_find_first( keys, _input.value, last );
			
			if ( last == 0 ) { break; }
			
			_ruleset	= ruleset[? string_char_at( _input.value, last ) ];
			_raw		= _ruleset[ 0 ];
			_func		= _ruleset[ 1 ];
			
			pre( _raw );
			
			var _i = 0; repeat( array_length( _func ) ) {
				_func[ _i++ ]( _input );
				
			}
			
		}
		return _input.value;
		
	}
	static close	= function() {
		ds_map_destroy( ruleset );
		
	}
	functions	= _functions;
	ruleset		= ds_map_create();
	keys		= "";
	last		= 0;
	flag		= 0;
	
	functions	= ( functions != undefined ? functions : {
		setup : function() {
			flag = 0;
			
		},
		pre : function( _rules ) {
			if ( string_pos( "ignore", _rules ) > 0 ) {
				flag |= 2;
				
			} else {
				flag ^= flag & 2;
				
			}
			
		},
		strip : function( _input ) {
			if ( flag & 1 && flag & 2 == 0 ) { return; }
			
			_input.value	= string_delete( _input.value, last--, 1 );
			
		},
		push : function( _input ) {
			if ( flag > 0 && flag & 2 == 0 ) { return; }
			
			_input.value	= string_insert( "\n", _input.value, last );
			
		},
		ignore : function() {
			flag	^= 1;
			
		}
		
	});
	if ( variable_struct_exists( functions, "pre" ) == false ) {
		pre	= function(){};
		
	} else {
		pre	= method( self, functions.pre );
		
	}
	if ( variable_struct_exists( functions, "setup" ) == false ) {
		setup	= function(){};
		
	} else {
		setup	= method( self, functions.setup );
		
	}
	rules( _format );
	
}
