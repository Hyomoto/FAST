/// @param {string} _item	The Thing definition.
/// @param {struct} _import	If provided, will be used for extend declarations.
/// @desc	Takes in a thing definition, converts it to a data structure and returns it.
function parse_thing( _item, _import = {}) {
	static error	= function( scan, _line, _error, _pattern = 1 ) {
		scan.pop();
		var _string = $"Thing - Line {_line} - {_error}\n"
		_string += $"Error at index ({scan.index}) - {scan.read( _pattern )}";
		return new Exception( _string );
		
	}
	static copy	= function( _from, _to, _static ) {
		if ( is_array( _from )) {
			var _i = 0; repeat( array_length( _from )) {
				array_push( _to, _from[ _i++ ] );
				
			}
			
		} else {
			var _names	= struct_get_names( _from );
			var _i = 0; repeat( array_length( _names )) {
				var _key	= _names[ _i++ ];
				if ( is_array( _from[$ _key ] )) {
					if ( !is_array( _to[$ _key ] )) {
						if ( _static && is_array( _static[$ _key ] ))
							_to[$ _key ]	= variable_clone( _static[$ _key ], 1 );
						else
							_to[$ _key	]	= [];
						static_get( parse_thing ).copy( _from[$ _key ], _to[$ _key ], undefined );
						
					}
					
				} else if ( is_struct( _from[$ _key ] )) {
					if ( !is_struct( _to[$ _key ])) {
						if ( _static && is_struct( _static[$ _key ] ))
							_to[$ _key ]	= variable_clone( _static[$ _key ], 1 );
						else
							_to[$ _key ]	= {};
						static_get( parse_thing ).copy( _from[$ _key ], _to[$ _key ], undefined );
						
					}
					
				} else {
					_to[$ _key ]	= _from[$ _key ];
					
				}
				
			}
			
		}
		
	};
	static value	= function( scan, error ) {
		if ( scan.peek() == "'" || scan.peek() == "\"" )
			return scan.read( scan.peek());
		if ( scan.isDigit() || scan.peek() == "-" )
			return real( scan.read( "n" ));
		if ( scan.match( "#" )) {
			var _css	= scan.read( "x" );
			if ( string_length( _css ) != 6 )
				throw error( scan, 3, "Bad CSS value, must have exactly six digits!", "S" );
			return real( "0x" + string_copy( _css, 5, 2 ) + string_copy( _css, 3, 2 ) + string_copy( _css, 1, 2 ));
			
		}
		if ( scan.match( "@" )) {
			var _asset	= scan.read( "S" );
			if ( asset_get_index( _asset ) == -1 )
				throw error( scan, 3, $"Bad asset definition, {_asset} index couldn't be resolved." );
			return asset_get_index( _asset );
			
		}
		var _read	= scan.read( "S" );
		switch( _read ) {
			case "True" : return bool( true );
			case "False": return bool( false);
			case "Nil"  : return undefined;
			
		}
		return _read;
		
	}
	static isLegal	= function( _c ) { return string_lettersdigits( _c ) != "" || _c == "_" }
	static scan	= new Scanner();
	
	scan.open( _item ).skip( "s" ); // open thing for scanning, discard leading whitespace
	
	var _thing	= undefined;
	var _type	= undefined;
	var _line	= string_count( "\n", scan.copy( 1, scan.index )) + 1;
	var _static	= undefined;
	
	// line 1 definition, type declaration
	if ( scan.match( "from" )) {
		var _from	= scan.skip( "s" ).push().read( "S" );
		if ( is_undefined( _import[$ _from ] ))
			throw error( scan, 1, $"From declaration not found: {_from}!", "S" );
		_thing	= _import[$ _from ].clone();
		_type	= _import[$ _from ].uid;
		_type	= string_copy( _type, 1, string_pos( "#", _type ) - 1 );
		
	} else if ( scan.match( "extend" )) {
		var _extend	= scan.skip( "s" ).push().read( "S" );
		if ( is_undefined( _import[$ _extend ] ))
			throw error( scan, 1, $"Extend declaration not found: {_extend}!", "S" );
		var _construct	= asset_get_index( instanceof( _import[$ _extend ] ));
		_thing	= new _construct();
		_static	= _import[$ _extend ];
		static_set( _thing, _import[$ _extend ] );
		_type	= _import[$ _extend ].uid;
		_type	= string_copy( _type, 1, string_pos( "#", _type ) - 1 );
		
	} else {
		// test for type conformity
		_type	= scan.push().read( isLegal );
		if ( string_digits( string_char_at( _type, 1 )) != "" || _type == "" )
			throw error( scan, 1, "Type declaration must start with a letter or underscore!", "S" );
		// test that script exists for type
		var _construct	= asset_get_index( _type );
		if ( script_exists( _construct ) == false )
			throw error( scan, 1, $"Invalid type declaration - {_type} not found!", "S" );
		// test if script is a constructor
		try{ _thing = new _construct(); }
		catch( _ex ) { throw error( scan, 1, $"Invalid type declaration - {_type} is not a constructor!", "S" ); }
		
	}
	
	scan.pop( false ).skip( "s" ) // type valid
	
	while ( scan.match( "import" )) {
		var _extend	= scan.skip( "s" ).push().read( "S" );
		_line	= string_count( "\n", scan.copy( 1, scan.index )) + 1;
		
		if ( is_undefined( _import[$ _extend ] ))
			throw error( scan, 1, $"Import declaration not found: {_extend}!", "S" );
		
		copy( _import[$ _extend ], _thing, _static );
		
		scan.pop( false ).skip( "s" );
		
	}
	
	// line 2 definition, name
	var _name	= ""
	
	_line	= string_count( "\n", scan.copy( 1, scan.index )) + 1;
	scan.push();
	
	switch( scan.peek()) {
		case "'" : case "\"" :	_name = scan.read( scan.peek()); break;
		default :				_name = scan.read( "S" ); break;
		
	}
	if ( _name == "" )
		throw error( scan, 2, $"Invalid name, names cannot be blank.", "S" );
	
	_thing.name	= _name;
	_thing.uid	= string_replace_all( string_lower( _type ) + "#" + string_lower( _name ), " ", "-" );
	
	scan.pop( false ).skip( "s" );
	
	_line	= string_count( "\n", scan.copy( 1, scan.index )) + 1;
	
	// line 3 definition, properties
	
	var _target	= [ _thing ];
	
	while( scan.isFinished() == false ) {
		if ( scan.match( "," )) { // ignore commas
			scan.skip( "s" );
			continue;
			
		}
		if ( scan.match( "//" )) { // ignore comments
			scan.skip( "\n" ).skip( "s" );
			continue;
			
		}
		scan.push();
		
		if ( is_array( array_last( _target ))) {
			if ( scan.match( "]" )) {
				array_pop( _target );
				
			} else if ( scan.match( "}" )) {
				throw error( scan, 3, $"Struct closure '\}' used without '\{' at line {_line}!", "S" );
				
			} else {
				if ( scan.match( "[" )) {
					var _array	= [];
					array_push( array_last( _target ), _array );
					array_push( _target, _array )
					
				} else if ( scan.match( "{" )) {
					var _struct	= {};
					array_push( array_last( _target ), _struct );
					array_push( _target, _struct )
					
				} else {
					var _value	= value( scan, error );
					array_push( array_last( _target ), _value );
					
				}
				
			}
			
		} else {
			if ( scan.match( "]" )) {
				throw error( scan, 3, $"Array closure ']' used without '[' at line {_line}!", "S" );
				
			} else if ( scan.match( "}" )) {
				if ( array_length( _target ) == 1 )
					throw error( scan, 3, "Struct closure '\}' used without '\{' at line {_line}.", "S" );
				array_pop( _target );
				
			} else {
				var _dot	= is_struct( array_last( _target )) && scan.match( "." );
				// test for property conformity
				var _property	= scan.read( isLegal );
				if ( string_digits( string_char_at( _property, 1 )) != "" || _property == "" )
					throw error( scan, 3, "Property declarations must start with a letter or underscore!", "S" );
				
				scan.skip( "s" );
				
				if ( _dot ) { // short declaration
					array_last( _target )[$ _property ]	= true;
					
				} else if ( scan.match( "[" )) {
					var _bang	= scan.match( "!" );
					if ( !is_array( array_last( _target )[$ _property ] )) {
						if ( !_bang && _static && is_array( _static[$ _property ] ))
							array_last( _target )[$ _property ] = variable_clone( _static[$ _property ], 1 );
						else
							array_last( _target )[$ _property ]	= [];
						
					}
					array_push( _target, array_last( _target )[$ _property ] )
					
				} else if ( scan.match( "{" )) {
					var _bang	= scan.match( "!" );
					if ( !is_struct( array_last( _target )[$ _property ] )) {
						if ( !_bang && _static && is_struct( _static[$ _property ] ))
							array_last( _target )[$ _property ] = variable_clone( _static[$ _property ], 1 );
						else
							array_last( _target )[$ _property ]	= {};
							
					}
					array_push( _target, array_last( _target )[$ _property ] )
					
				} else {
					var _value	= value( scan, error );
					array_last( _target )[$ _property ]	= _value;
					
				}
				
			}
				
		}
		var _mark	= scan.index;
		scan.pop( false ).skip( "s" ) // line 1 valid
		
		if ( string_pos( "\n", scan.copy( _mark, scan.index )) > 0 )
			_line += 1;
		
	}
	if ( _static )
		static_set( _thing, _static );
	
	return _thing;
	
}
