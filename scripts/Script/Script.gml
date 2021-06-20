/// @func Script
function Script() : __Struct__() constructor {
	/// @param {struct}	vars	A struct containing variables
	/// @param {int}	start	A line to start execution at
	/// @desc	Executes the given script with the provided variables at the stated line.
	/// @returns mixed
	static execute		= function( _global, _data ) {
		static __put__	= function( _var, _value, _data, _global ) {
			static	__parser	= new ( __FAST_script_config__().parser )(".");
			//__parser.__Divider	= ".";
			__parser.parse( _var );
			
			var _key	= __parser.next()
			var _local	= _data.local;
			var _source;
			
			if ( variable_struct_exists( _local, _key ) || _global == undefined ) { _source = _local; }
			else { _source = _global; }
			
			while ( __parser.has_next() ) {
				if ( is_struct( _source ) ) { _source = _source[$ _key ]; }
				else { _source = variable_instance_get( _source, _key ); }
				
				if ( struct_type( _source, ScriptSafe ))
					throw new BadScriptFormat( "BAD VARIABLE", __Source, string( _data.last ), "Could not find " + _var + "!");
				
				_key	= __parser.next();
				
			}
			if ( is_struct( _source ) ) { _source[$ _key ] = _value; }
			else { variable_instance_set( _source, _key, _value ); }
			
		}
		static __eval__	= function( _node, _data, _global ) {
			try {
				var _out	= evaluate_expression( _node, _data, _global )
				
			} catch ( _ex ) {
				throw new BadScriptFormat( "BAD VARIABLE", __Source, string( _data.last ), _ex.message );
				
			}
			return _out;
			
		}
		// # if the script is being started from the top
		if ( _data == undefined ) {
			_data	= {
				local : {},			// the local scope
				line  : 0,			// current line to execute
				ident : 0,			// last level of indentation
				loopTo: new Stack(),// line to loop back to
				coro  : {},			// list of coroutines
				last  : 0,
			}
			var _j = 0; repeat( array_length( __Header ) ) {
				_data.local[$ __Header[ _j ] ] = _j + 2 < argument_count ? argument[ _j + 2 ] : undefined;
				++_j;
			}
			
		}
		// set up execution variables
		var _local	= _data.local;
		var _line	= _data.line;
		var _ident	= _data.ident;
		var _loopto	= _data.loopTo;
		var _coro	= _data.coro;
		var _lastid	= 0;
		
		// seek the next line in the jump table after the current line
		var _exto	= array_binary_search( __Base, _line );
		if ( error_type( _exto ) == ValueNotFound ) { _exto = _exto.index; }
		
		__Timer.reset();
		
		while ( _line < __Size ) {
			// set indentation level
			_lastid	= _ident;
			_ident	= __Content[ _line ][ 0 ];
			_data.last	= __Content[ _line ][ 4 ]
			// update exto table jump position
			while ( _line > __Base[ _exto ] ) { _exto++; }
			// check if script has executed for too long
			if ( __Timer.elapsed() > __Timeout )
				throw new __Error__().from_string( "Script execution took too long, execution aborted!" );
			// loop if loop
			if ( _loopto.size() > 0 && _ident < _loopto.top().ident ) {
				var _pop	= _loopto.pop();
				_line	= _pop.line;
				_ident	= _pop.ident;
				
			}
			switch ( __Content[ _line ][ 2 ] ) {
				case "if" : // if
					var _eval	= __eval__( __Content[ _line ][ 3 ], _data, _global );
					if ( _eval == false || _eval == undefined ) {
						_line	=  __Content[ _line ][ 1 ] == undefined ? __Base[ _exto ] : __Content[ _line ][ 1 ];
						continue;
						
					} break;
					
				case "el" : // else
					var _eval	= __eval__( __Content[ _line ][ 3 ], _data, _global );
					if ( _ident < _lastid || _eval == false ) {
						_line = __Content[ _line ][ 1 ] == undefined ? __Base[ _exto ] : __Content[ _line ][ 1 ];
						continue;
					} break;
					
				case "wh" : // while
					var _eval	= __eval__( __Content[ _line ][ 3 ], _data, _global );
					if ( _eval == false || _eval == undefined ) {
						_line	=  __Content[ _line ][ 1 ] == undefined ? __Base[ _exto ] : __Content[ _line ][ 1 ];
						continue;
						
					}
					_loopto.push({ line: _line, ident: __Content[ _line ][ 0 ] + 1 });
					
					break;
					
				case "re" : // return
					return {
						result: __eval__( __Content[ _line ][ 3 ], _data, _global ),
						state: FAST_SCRIPT_RETURN
					}
					
				case "yi" : // yield
					_data.ident	= _ident;
					_data.line	= __Content[ _line ][ 3 ].wait == undefined || !__eval__( __Content[ _line ][ 3 ].wait, _data, _global ) ? _line + 1: _line;
					_data.result= __eval__( __Content[ _line ][ 3 ].yield, _data, _local )
					_data.state	= FAST_SCRIPT_YIELD
					
					return _data;
					
				case "va" : // temp
					var _j = 0; repeat( array_length( __Content[ _line ][ 3 ][ 0 ] ) ) {
						var _eval	= __Content[ _line ][ 3 ][ 1 ] == undefined ? undefined : __eval__( __Content[ _line ][ 3 ][ 1 ][ _j ], _data, _global );
						__put__( __Content[ _line ][ 3 ][ 0 ][ _j ], _eval, _data, undefined );
						++_j;
					}
					break;
					
				case "pu" : // put
					var _j = 0; repeat( array_length( __Content[ _line ][ 3 ][ 0 ] ) ) {
						var _eval	= __eval__( __Content[ _line ][ 3 ][ 1 ][ _j ], _data, _global );
						__put__( __Content[ _line ][ 3 ][ 0 ][ _j ], _eval, _data, _global );
						++_j;
					}
					break;
					
				case "lo" : // load
					var _key		= __Content[ _line ][ 3 ][ 0 ];
					var _filename	= __eval__( __Content[ _line ][ 3 ][ 1 ], _data, _global );
					// error handling
					if ( is_string( _filename ) == false ) { throw new InvalidArgumentType( "load", 0, _filename, "string" ); }
					if ( file_exists( _filename ) == false ) { throw new FileNotFound( "load", _filename ); }
					if ( _key == undefined ) {
						var _name	= filename_name( _filename );
						var _dot	= string_pos( ".", _name );
						
						_key	= _dot == 0 ? _name : string_copy( _name, 1, _dot - 1 );
						
					}
					// get script name
					if ( is_string( _key ) == false ) { throw new InvalidArgumentType( "load", 1, _key, "string" ); }
					
					__put__( _key, new Script().from_input( new TextFile().open( _filename )), _data, _global );
					
					break;
					
				case "0x" : __eval__( __Content[ _line ][ 3 ], _data, _global ); break;
				default :
					throw new __Error__().from_string( "Unexpected byte code enountered in Script: " + __Content[ _i ][ 2 ] );
					
			}
			++_line;
			
		}
		throw new __Error__().from_string( "Script " + __Source + " ended in an unexpected way!" );
		
	}
	/// @param {__InputStream__}	An input source
	/// @desc	Populates the script using the given input source.
	/// @returns self
	static from_input	= function( _input ) {
		static __rtrim__	= function( _string ) {
			var _end	= string_length( _string );
			repeat ( _end ) {
				if ( not string_pos( string_char_at( _string, _end ), " \t" ) )
					break;
				_end--;
			}
			return string_copy( _string, 1, _end );
		}
		static __ident__	= function( _string ) {
			var _n = 0; repeat( string_length( _string ) ) {
				if ( string_pos( string_char_at( _string, 1 + _n ), " \t" ) == 0 ) { break; }
				++_n;
			}
			return string_copy( _string, 1, _n );
			
		}
		static __parse_variable__	= function( _string ) {
			var _i = 0; repeat( string_count( ".", _string ) + 1 ) {
				if ( _i > 0 && string_char_at( _string, _i - 1 ) == "." )
					throw new __Error__().from_string( "Failed at position " + string( _i ) + ". Variable names must be longer than 0!\n>> " + _string );
				if ( string_char_at( _string, _i + 1 ) == "_" )
					throw new __Error__().from_string( "Failed at position " + string( _i ) + ". Variable names can not begin with _!\n>> " + _string );
				_i	= string_pos_ext( ".", _string, _i );
				
			}
			return _string;
			
		}
		if ( struct_type( _input, __InputStream__ ) == false )
			throw new InvalidArgumentType( "Script.from_input", 0, _input, "__InputStream__" );
		
		static __parser	= new Parser(" \t");
		
		var _list	= new LinkedList();
		var _idents	= [ "", undefined, undefined ];
		var _indent	= 0;
		var _stack	= new Stack();
		var _lines	= 0;
		var _nexti	= 0;
		
		while ( _input.finished() == false ) { ++_lines;
			var _line	= __rtrim__( _input.read() );
			
			if ( _line == "" ) { continue; }
			if ( string_copy( string_trim( _line ), 1, 2 ) == "//" ) { continue; }
			
			if ( _list.size() == 0 && string_copy( _line, 1, 4 ) == "func" ) {
				__Header = string_explode( string_delete( _line, 1, 4 ), ",", true );
				// need to test for reserved keywords? maybe not
				continue;
			}
			var _i	= array_simple_search( _idents, __ident__( _line ));
			
			if ( error_type( _i ) == ValueNotFound ) {
				if ( string_length( __ident__( _line )) <= string_length( _idents[ _indent ] ))
					throw new BadScriptFormat( "BAD INDENTATION", _input.__Source, _lines, _line);
				if ( _indent + 1 < array_length( _idents ) && _idents[ _indent + 1 ] != undefined )
					throw new BadScriptFormat( "BAD INDENTATION", _input.__Source, _lines, _line);
				_idents[ _indent + 1 ] = __ident__( _line );
				_i = _indent + 1;
			}
			if ( _nexti > -1 ){
				if ( _i < _nexti )
					throw new BadScriptFormat( "TOO LITTLE INDENTATION", _input.__Source, _lines, _line );
				else if ( _i > _nexti )
					throw new BadScriptFormat( "TOO MUCH INDENTATION", _input.__Source, _lines, _line );
				_nexti	= -1;
				
			} else if ( _i > _indent ) {
				throw new BadScriptFormat( "UNEXPECTED INDENTATION", _input.__Source, _lines, _line );
			}
			_line	= string_delete( _line, 1, string_length( _idents[ _i ] ))
			
			__parser.parse( _line );
			
			if ( _i > _indent ) {
				_stack.push([ _indent, _list.size() - 1 ]);
				
			} else if ( _i < _indent ) {
				while ( _stack.top()[ 0 ] != _i ) {
					_stack.pop();
				}
				_list.index( _stack.pop()[ 1 ] )[@ 1 ] = _list.size();
				
				if ( __parser.peek() != "else" ) {
					array_push( __Base, _list.size() );
				}
				
			}
			var _code	= "if";
			var _exp	= undefined;
			
			try {
				switch( __parser.next() ) {
					case "if"		: _code = "if"; _exp = parse_expression( __parser.remaining() ); _nexti = _i + 1; break;
					case "else"		: _code = "el"; _exp = __parser.has_next() ? parse_expression( __parser.remaining()) : true; _nexti = _i + 1; break;
					case "return"	: _code = "re"; _exp = __parser.has_next() ? parse_expression( __parser.remaining()) : undefined; break;
					case "temp"		: _code = "va";
						var _t	= string_explode( __parser.remaining(), string_pos( " as ", __parser.remaining() ) ? " as " : "=", true );
						var _left	= string_explode( _t[ 0 ], ",", true );
					
						if ( array_length( _t ) > 1 ) {
							var _right	= string_explode( _t[ 1 ], ",", true );
							
							if ( array_length( _left ) != array_length( _right )) { throw new __Error__().from_string( "temp values must match assignments" ); }
							var _j = 0; repeat( array_length( _right ) ) {
								_right[ _j ]	= parse_expression( _right[ _j ] );
								++_j;
							}
							_exp	= [ _left, _right ];
						
						} else {
							_exp	= [ _left, undefined ];
						
						}
						break;
					
					case "put"		: _code = "pu";
						var _t	= string_explode( __parser.remaining(), " into ", true );
						var _left	= string_explode( _t[ 0 ], ",", true );
						
						if ( array_length( _t ) > 1 ) {
							var _right	= string_explode( _t[ 1 ], ",", true );
							
							if ( array_length( _left ) != array_length( _right )) { throw new __Error__().from_string( "temp values must match assignments" ); }
							var _j = 0; repeat( array_length( _left ) ) {
								_left[ _j ]	= parse_expression( _left[ _j ] );
								_right[_j ] = __parse_variable__( _right[ _j ] );
								++_j;
							}
							_exp	= [ _right, _left ];
						
						} else {
							_exp	= [ [ _t[ 0 ] ], undefined ];
							
						}
						break;
				
					case "load"		: _code = "lo";
						var _t	= string_explode( __parser.remaining(), " as ", true );
						var _exp	= [ undefined, parse_expression( _t[ 0 ] ) ];
						
						if ( array_length( _t ) > 1 )
							_exp[ 1 ]	= _t[ 1 ];
						
						break;
					
					case "while"	: _code = "wh";
						_exp	= parse_expression( __parser.remaining() );
						_nexti	= _i + 1; 
						break;
					
					case "yield"	: _code = "yi";
						var _yield	= string_explode( __parser.has_next() ? __parser.remaining() : "", " while ", true );
					
						_exp	= { yield: undefined, wait: undefined }
					
						if ( array_length( _yield ) > 0 ) {
							_exp.yield = parse_expression( _yield[ 0 ] );
						
						}
						if ( array_length( _yield ) > 1 ) {
							_exp.wait = parse_expression( _yield[ 1 ] );
						
						}
						break;
					
					default			:
						_code = "0x"; _exp = parse_expression( _line ); break;
					
				}
			} catch ( _ex ) {
				throw new BadScriptFormat( "ERROR PARSING", _input.__Source, _lines, _line + "\n" + _ex.message );
				
			}
			_indent = _i;
			
			_list.push([ _indent, undefined, _code, _exp, _lines ]);
			
		}
		if ( _list.size() == 0 || _indent > 0 || _list.last()[ 2 ] != "re" ) {
			array_push( __Base, _list.size() );
			_list.push([ 0, undefined, "re", undefined, _lines ]);
			
		}
		__Source	= _input.__Source;
		__Content	= _list.to_array();
		__Size		= array_length( __Content );
		_input.close();
		
		return self;
		
	}
	static timeout	= function( _value ) {
		__Timeout	= _value;
		
		return self;
		
	}
	static size	= function() {
		return __Size;
		
	}
	__Source	= "unknown"
	__Timer		= new Timer();
	__Timeout	= 250000;
	__Header	= [];
	__Base		= [];
	__Size		= 0;
	__Content	= undefined;
	
	__Type__.add( Script );
	
}
/// @func BadScriptFormat
/// @desc	Returned when a search is made for a value that doesn't exist in a data structure.
/// @wiki Core-Index Errors
function BadScriptFormat( _type, _source, _line_number, _line ) : __Error__() constructor {
	message	= conc( _type, " at line ", _line_number, " in " + _source + "!\n>> " + _line);
}
