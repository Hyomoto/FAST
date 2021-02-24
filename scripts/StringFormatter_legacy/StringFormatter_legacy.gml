/// @func StringFormatter_old
/// @param {string}	format_rules	The rules to use when formatting strings
/// @desc Used to define a set of rules that can be used to format strings, such as stripping off uneccessary
// characters, and adding line breaks. By default the formatter accepts a few rules, but it is also
// possible to write your own rule libraries which can then be used instead. The built-in rules are:\n
// ##### strip, push, pull, ignore, pre_indent, post_indent\n
// >*NOTE: StringFormatter makes use of dynamic resources, and so should always be destroyed when no longer needed to prevent memory leaks which will slow down and eventually crash your game.*
/// @example
//var _formatter = new StringFormatter( " :strip,\t:strip" );
//
//show_debug_message( _formatter.format( "  Hello	World!" ) );
/// @wiki Core-Index Parsing
function StringFormatter_old( _format, _functions ) constructor {
	/// @desc Processes the format into a set of rules the formatter can then use.
	/// @param {string} rules	A comma-separated list of rules to use when formatting the string. The rules are defined as part of the rules library.
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
	/// @desc Takes the input, applies the ruleset, and returns the modified string.
	/// @param {string} input The string to format
	/// @returns string
	static format	= function( _input ) {//, _output, _params ) {
		var _ruleset, _raw, _func;
		
		input.value	= _input;
		
		setup( input );
		last	= 0;
		
		while( true ) {
			last	= string_find_first( keys, input.value, last );
			
			if ( last == 0 ) { break; }
			
			_ruleset	= ruleset[? string_char_at( input.value, last ) ];
			_raw		= _ruleset[ 0 ];
			_func		= _ruleset[ 1 ];
			
			pre( _raw );
			
			input.index = 0; repeat( array_length( _func ) ) {
				_func[ input.index++ ]( input );
				
			}
			
		}
		return input.value;
		
	}
	/// @desc Cleans up the internal data structures, allowing the StringFormatter to be garbage-collected safely.
	static destroy	= function() {
		ds_map_destroy( ruleset );
		
	}
	/// @desc the internal function library used for building rulesets
	functions	= _functions;
	/// @desc the map containing the current rules in use
	ruleset		= ds_map_create();
	/// @desc a string containing all of the keys in the map
	keys		= "";
	/// @desc the last index of the string that was operated on
	last		= 0;
	/// @desc an internal flag used for setting formatting state
	flag		= 0;
	/// @desc a package that is passed through the rulesets to operate on the string
	input		= { value : "", index : 0 }
	///@override
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
			
			_input.value	= string_insert( "\n", _input.value, ++last );
			
		},
		pull : function( _input ) {
			if ( flag > 0 && flag & 2 == 0 ) { return _input; }
			
			_input.value	= string_insert( "\n", _input.value, last++ );
			
		},
		post_indent : function( _input ) {
			if ( flag > 0 && flag & 2 == 0 ) { return; }
			
			_input.value	= string_insert( "\t", _input.value, ++last );
			
		},
		pre_indent : function( _input ) {
			if ( flag > 0 && flag & 2 == 0 ) { return _input; }
			
			_input.value	= string_insert( "\t", _input.value, last++ );
			
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
