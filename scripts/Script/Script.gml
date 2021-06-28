/// @func Script
function Script() : __Struct__() constructor {
	static __pool__	= new ObjectPool();
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
			
			repeat( __parser.count() ) {
				_source = variable_instance_get( _source, _key );
				_key	= __parser.next();
				
				//if ( FAST_SCRIPT_PROTECT_FUNCTIONS && struct_type( _source, ScriptFunctionWrapper ))
				//	throw new BadScriptFormat( "BAD VARIABLE", __Source, string( _data.last ), "Could not find " + _var + "!");
				
			}
			variable_instance_set( _source, _key, _value );
			
		}
		static __eval__	= function( _node, _data, _global ) {
			try {
				var _out	= evaluate_expression( _node, _data, _global )
				
			} catch ( _ex ) {
				throw new BadScriptFormat( "BAD VARIABLE", __Source, string( _data.last ), _ex.message );
				
			}
			return _out;
			
		}
		static __code__	= [ // language byte table
			function( _content, _data, _global, _eval_, _put_ ) { // 0, if
				var _eval	= _eval_( _content[ 3 ], _data, _global );
				if ( _eval == false || _eval == undefined ) {
					_data.line	= _content[ 1 ] == undefined ? _data.line = __Base[ _data.exto ] : _content[ 1 ];
					return true;
				}
			},
			function( _content, _data, _global, _eval_, _put_ ) { // 1, else
				var _eval	= _eval_( _content[ 3 ], _data, _global );
				if ( _content[ 0 ] < _data.ident || _eval == false ) {
					_data.line = _content[ 1 ] == undefined ? __Base[ _data.exto ] : _content[ 1 ];
					return true;
				}
			},
			function( _content, _data, _global, _eval_, _put_ ) { // 2, while
				var _eval	= _eval_( _content[ 3 ], _data, _global );
				if ( _eval == false || _eval == undefined ) {
					_data.line	= _content[ 1 ] == undefined ? __Base[ _data.exto ] : _content[ 1 ];
					return true;
				}
				var _struct	= __pool__.get();
				
				_struct.line	= _data.line;
				_struct.ident	= _content[ 0 ] + 1;
				
				_data.loopTo.push(_struct);
				
			},
			function( _content, _data, _global, _eval_, _put_ ) { // 3, return
				//var _struct	= { result: _eval_( _content[ 3 ], _data, _global ), state: FAST_SCRIPT_RETURN };
				with( __pool__.get() ) {
					result	= _eval_( _content[ 3 ], _data, _global );
					state	= FAST_SCRIPT_RETURN;
					return self;
				}
				
			},
			function( _content, _data, _global, _eval_, _put_ ) { // 4, yield
				_data.ident	= _content[ 0 ];
				_data.line	= _content[ 3 ].wait == undefined || !_eval_( _content[ 3 ].wait, _data, _global ) ? _data.line + 1: _data.line;
				_data.result= _eval_( _content[ 3 ].yield, _data, _data.local );
				_data.state	= FAST_SCRIPT_YIELD;
				return _data;
			},
			function( _content, _data, _global, _eval_, _put_ ) { // 5, temp
				var _j = 0; repeat( array_length( _content[ 3 ][ 0 ] ) ) {
					var _eval	= _content[ 3 ][ 1 ] == undefined ? undefined : _eval_( _content[ 3 ][ 1 ][ _j ], _data, _global );
					_put_( _content[ 3 ][ 0 ][ _j ], _eval, _data, undefined );
					++_j;
				}
			},
			function( _content, _data, _global, _eval_, _put_ ) { // 6, put
				var _j = 0; repeat( array_length( _content[ 3 ][ 0 ] ) ) {
					var _eval	= _eval_( _content[ 3 ][ 1 ][ _j ], _data, _global );
					_put_( _content[ 3 ][ 0 ][ _j ], _eval, _data, _global );
					++_j;
				}
			},
			function( _content, _data, _global, _eval_, _put_ ) { // 7, load
				var _key		= _content[ 3 ][ 0 ];
				var _filename	= _eval_( _content[ 3 ][ 1 ], _data, _global );
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
				
				_put_( _key, new Script().from_input( new TextFile().open( _filename )), _data, _global );
				
			},
			function( _content, _data, _global, _eval_, _put_ ) { // 8, execute
				_eval_( _content[ 3 ], _data, _global )
			},
			function( _content, _data, _global, _eval_, _put_ ) {
				if ( __fast_script_origin__() == undefined )
					show_debug_message( strf("{1} line {2} : {0}", _eval_( _content[ 3 ], _data, _global ), __Source, _data.last ) );
				else
					( __fast_script_origin__().trace )( strf("{1} line {2} : {0}", _eval_( _content[ 3 ], _data, _global ), __Source, _data.last ) );
				//"UNEXPECTED INSTRUCTION CODE", __Source, string( _data.last ) );
			}
		];
		// # if the script is being started from the top
		if ( _data == undefined ) {
			_data	= {
				local : {},			// the local scope
				line  : 0,			// current line to execute
				ident : 0,			// last level of indentation
				loopTo: new Stack(),// line to loop back to
				coro  : {},			// list of coroutines
				last  : 0,			// last script line
				exto  : 0,			// jumpto line
			}
			// seek the next line in the jump table after the current line
			var _jump_index	= array_binary_search( __Base, _data.line );
			if ( error_type( _jump_index ) == ValueNotFound ) { _jump_index = _jump_index.index; }
			_data.exto	= _jump_index;
			// import header variables into local table
			var _j = 0; repeat( array_length( __Header ) ) {
				_data.local[$ __Header[ _j ] ] = _j + 2 < argument_count ? argument[ _j + 2 ] : undefined;
				++_j;
			}
			
		}
		// set up execution variables
		var _ident	= _data.ident;
		var _loopto	= _data.loopTo;
		
		__Timer.reset();
		
		while ( _data.line < __Size ) {
			// set up convenience vars
			var _line		= _data.line;
			var _content	= __Content[ _line ];
			// loop if loop
			if ( _loopto.size() > 0 && _content[ FAST_SCRIPT_INDEX.INDENT ] < _loopto.top().ident ) {
				var _struct = __pool__.put( _loopto.pop() );
				_data.line	= _struct.line;
				continue;
				
			}
			// set indentation level
			_data.ident	= _ident;
			_data.last	= _content[ FAST_SCRIPT_INDEX.DEBUG_LINE ];
			// update exto table jump position
			while ( _line > __Base[ _data.exto ] ) { _data.exto++; }
			// check if script has executed for too long
			if ( __Timer.elapsed() > __Timeout )
				throw new __Error__().from_string( "Script execution took too long, execution aborted!" );
			
			if ( _content[ FAST_SCRIPT_INDEX.INSTRUCTION ] >= FAST_SCRIPT_CODE.LAST_BYTE ) {
				throw new BadScriptFormat( "UNEXPECTED INSTRUCTION CODE", __Source, string( _data.last ) );
			}
			var _output	= __code__[ _content[ FAST_SCRIPT_INDEX.INSTRUCTION ] ]( _content, _data, _global, __eval__, __put__ );
			// instruction has ended/yielded
			if ( is_struct( _output ) ) { return _output; }
			// instruction has called jump to
			if ( _output == true ) { continue; }
			// normal progression
			_ident	= _content[ FAST_SCRIPT_INDEX.INDENT ];
			_data.line += 1;
			
		}
		throw new __Error__().from_string( "Script " + __Source + " ended in an unexpected way!" );
		
	}
	/// @param {__InputStream__}	input	An input source
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
		if ( struct_type( _input, __Stream__ ))
			_input	= new __Stream__( _input ).open();
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
			syslog( _line );
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
			var _code	= 0;
			var _exp	= undefined;
			
			try {
				switch( __parser.next() ) {
					case "trace"	: _code = FAST_SCRIPT_CODE.TRACE; _exp = parse_expression( __parser.remaining() ); break;
					case "if"		: _code = FAST_SCRIPT_CODE.IF; _exp = parse_expression( __parser.remaining() ); _nexti = _i + 1; break;
					case "else"		: _code = FAST_SCRIPT_CODE.ELSE; _exp = __parser.has_next() ? parse_expression( __parser.remaining()) : true; _nexti = _i + 1; break;
					case "return"	: _code = FAST_SCRIPT_CODE.RETURN; _exp = __parser.has_next() ? parse_expression( __parser.remaining()) : undefined; break;
					case "temp"		: _code = FAST_SCRIPT_CODE.TEMP;
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
					
					case "put"		: _code = FAST_SCRIPT_CODE.PUT;
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
				
					case "load"		: _code = FAST_SCRIPT_CODE.LOAD;
						var _t	= string_explode( __parser.remaining(), " as ", true );
						var _exp	= [ undefined, parse_expression( _t[ 0 ] ) ];
						
						if ( array_length( _t ) > 1 )
							_exp[ 1 ]	= _t[ 1 ];
						
						break;
					
					case "while"	: _code = FAST_SCRIPT_CODE.WHILE;
						_exp	= parse_expression( __parser.remaining() );
						_nexti	= _i + 1; 
						break;
					
					case "yield"	: _code = FAST_SCRIPT_CODE.YIELD;
						var _yield	= string_explode( __parser.has_next() ? __parser.remaining() : "", " while ", true );
					
						_exp	= { yield: undefined, wait: undefined }
					
						if ( array_length( _yield ) > 0 ) {
							_exp.yield = parse_expression( _yield[ 0 ] );
						
						}
						if ( array_length( _yield ) > 1 ) {
							_exp.wait = parse_expression( _yield[ 1 ] );
						
						}
						break;
					
					default			: _code = FAST_SCRIPT_CODE.EXECUTE;
						_exp = parse_expression( _line ); break;
					
				}
			} catch ( _ex ) {
				throw new BadScriptFormat( "ERROR PARSING", _input.__Source, _lines, _line + "\n" + _ex.message );
				
			}
			_indent = _i;
			
			_list.push([ _indent, undefined, _code, _exp, _lines ]);
			
		}
		if ( _list.size() == 0 || _indent > 0 || _list.last()[ 2 ] != "re" ) {
			array_push( __Base, _list.size() );
			_list.push([ 0, undefined, FAST_SCRIPT_CODE.RETURN, undefined, _lines ]);
			
		}
		__Source	= _input.__Source;
		__Content	= _list.to_array();
		__Size		= array_length( __Content );
		_input.close();
		
		return self;
		
	}
	/// @param {string}	string	A string to convert into a script
	/// @desc	Converts the given string into a script. All normal rules apply.  You can use \n
	///		to create a new line.
	/// @returns self
	static from_string	= function( _string ) {
		if ( _string == "" ) { return; }
		
		var _queue	= new __Stream__( new Queue() ).open();
		
		_queue.__Source	= "string";
		
		var _i = 0; repeat( string_count( "\n", _string ) + 1) {
			var _l	= string_pos_ext( "\n", _string, _i );
			
			if ( _l == 0 ) { _l = string_length( _string ) + 1 };
			
			_queue.write( string_copy( _string, _i + 1, _l - _i ));
			
			_i	= _l;
			
		}
		return from_input( _queue );
		
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
