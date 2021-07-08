/// @func Script
function Script() : __Struct__() constructor {
	static from_lump	= function() {
		__UseLump	= true;
		
		return self;
		
	}
	static use_global	= function( _struct ) {
		__Global	= _struct;
		
		return self;
		
	}
	static restrict		= function( _restrict ) {
		__Restrict	= _restrict;
		
		return self;
		
	}
	static execute	= function() {
		// Object pool for throwaway structs
		static __pool__	= new ObjectPool();
		// Function to push values into paths
		static __put__	= function( _path, _value, _lump ) {
			static	__parser__	= new ( __FAST_script_config__().parser )(".");
			//__parser.__Divider	= ".";
			__parser__.parse( _path );
			
			var _key	= __parser__.next();
			var _lookup	= _lump.lookup;
			
			var _i = 0; repeat( array_length( _lookup )) {
				var _scope	= _lookup[ _i ];
				if ( variable_instance_exists( _scope, _key ))
					break;
				++_i;
			}
			repeat( __parser__.count() ) {
				if ( variable_instance_exists( _scope, _key ) == false )
					throw new ValueNotFound( "__put__", _path, _key );
				_scope	= variable_instance_get( _scope, _key );
				_key	= __parser__.next();
				
			}
			if ( variable_instance_exists( _scope, "__read_only__" ))
				throw new BadScriptFormat( "BAD INSTRUCTION :: ", __Source, _lump.last, "Could not 'put' because scope was read only." );
			
			variable_instance_set( _scope, _key, _value );
			
		}
		// Function evaluation wrapper for error handling
		static __eval__	= function( _exp, _lump ) {
			try { var _out	= _exp.evaluate( _lump.lookup, _lump ); }
			catch ( _ex ) {
				throw new BadScriptFormat( "BAD VARIABLE :: ", __Source, _lump.last, _ex.message );
				
			}
			return _out;
			
		}
		// Function to check for loop and pool struct
		static __is_loop__	= function( _line, _loop, _pool_ ) {
			if ( _loop.size() > 0 && _line[ FAST_SCRIPT_INDEX.INDENT ] < _loop.peek().indent ) {
				_pool_.put( _loop.peek() );
				return true;
			}
			return false;
			
		}
		// Function to test for True
		static __is_false__	= function( _v ) {
			return _v == undefined || not _v;
			
		}
		// define passed arguments and generate lump
		var _lump;
		
		if ( __UseLump ) {
			_lump	= argument_count == 0 ? __Lump : argument[ 0 ];
			
		} else {
			var _lump	= {
				lookup	: __Global == undefined ? [ {} ] : [ {}, __Global ],	// scope
				loopto	: new Stack(),	// loop stack
				coro	: {},			// coroutine map
				jumpto	: 0,			// last jumpto line
				indent	: 1,			// last indentation
				line	: 0,			// line to execute
				last	: 0,			// script line number(for errors)
				state	: FAST_SCRIPT_RETURN,
				restrict: __Restrict,
			}
			var _header	= __Content[ 0 ];
			// read in arguments as local vars
			if ( _header[ FAST_SCRIPT_INDEX.INSTRUCTION ] == FAST_SCRIPT_CODE.TEMP ) {
				var _arg	= _header[ FAST_SCRIPT_INDEX.DATA ].w;
				var _val	= _header[ FAST_SCRIPT_INDEX.DATA ].e;
				var _local	= _lump.lookup[ 0 ];
				
				var _i = 0; repeat( array_length( _arg )) {
					if ( argument_count > _i )
						_local[$ _arg[ _i ]]	= argument[ _i ];
					else 
						_local[$ _arg[ _i ]]	= _val == undefined || array_length( _val ) <= _i ? undefined : _val[ _i ];
					++_i;
				}
				_lump.line	+= 1;
				
			}
			// seek the next line in the jump table after the current line
			var _jump_index	= array_binary_search( __Jumpto, _lump.line );
			if ( error_type( _jump_index ) == ValueNotFound )
				_jump_index	= _jump_index.index;
			_lump.jumpto	= _jump_index;
			
		}
		// reset execution variables
		__UseLump	= false;
		__Global	= undefined;
		__Lump		= undefined;
		__Restrict	= undefined;
		
		// set up execution shortcuts
		var _indent	= _lump.indent;
		var _loopto	= _lump.loopto;
		
		__timer__.reset();
		
		while( _lump.line < __Size ) {
			var _line	= __Content[ _lump.line ];
			
			// Handle loop if it exists
			if ( _loopto.size() > 0 && _line[ FAST_SCRIPT_INDEX.INDENT ] < _loopto.peek().indent ) {
				__pool__.put( _loopto.peek() );
				_lump.line	= _loopto.pop().line;
				
				_line	= __Content[ _lump.line ];
				
			}
			// write position info
			_lump.indent	= _indent;
			_lump.last		= _line[ FAST_SCRIPT_INDEX.DEBUG_LINE ];
			
			// update jump table position
			while( _lump.line > __Jumpto[ _lump.jumpto ] ) { _lump.jumpto += 1; }
			
			// break script if execution is taking too long
			if ( __timer__.elapsed() > __Timeout )
				throw new __Error__().from_string( "Script aborted, execution took too long!" );
			
			// evaluate expressions
			var _data	= _line[ FAST_SCRIPT_INDEX.DATA ];
			var _exp	= is_struct( _data ) ? _data.e : _data;
			var _res	= undefined;
			
			if ( is_array( _exp )) {
				_res	= array_create( array_length( _exp ));
				
				var _i = 0; repeat( array_length( _exp ) ) {
					_res[ _i ]	= __eval__( _exp[ _i ], _lump );
					++_i;
				}
				
			} else if ( _exp != undefined ) {
				_res	= __eval__( _exp, _lump );
				
			}
			if ( _lump.restrict != undefined && is_numeric( array_binary_search( _lump.restrict, _line[ FAST_SCRIPT_INDEX.INSTRUCTION ] )) )
				throw new BadScriptFormat( "BAD INSTRUCTION :: ", __Source, _lump.last, "Instruction is disabled, and cannot be called." );
			
			// execute instructions
			switch ( _line[ FAST_SCRIPT_INDEX.INSTRUCTION ] ) {
				case FAST_SCRIPT_CODE.IF :
					if ( __is_false__( _res )) {
						_lump.line	= _line[ FAST_SCRIPT_INDEX.JUMPTO ] == undefined ? __Jumpto[ _lump.jumpto ] : _line[ FAST_SCRIPT_INDEX.INDENT ];
						continue;
					}
					break;
					
				case FAST_SCRIPT_CODE.ELSE :
					if ( _line[ FAST_SCRIPT_INDEX.INDENT ] < _lump.indent || __is_false__( _res )) {
						_lump.line	= _line[ FAST_SCRIPT_INDEX.JUMPTO ] == undefined ? __Jumpto[ _lump.jumpto ] : _line[ FAST_SCRIPT_INDEX.INDENT ];
						continue;
					}
					break;
				
				case FAST_SCRIPT_CODE.WHILE :
					if ( __is_false__( _res )) {
						_lump.line	= _line[ FAST_SCRIPT_INDEX.JUMPTO ] == undefined ? __Jumpto[ _lump.jumpto ] : _line[ FAST_SCRIPT_INDEX.INDENT ];
						continue;
					}
					with ( __pool__.get() ) {
						indent	= _line[ FAST_SCRIPT_INDEX.INDENT ] + 1;
						line	= _lump.line;
						
						_loopto.push( self );
						
					}
					break;
					
				case FAST_SCRIPT_CODE.RETURN :
					_lump.state	= FAST_SCRIPT_RETURN;
					
					__Lump	= _lump;
					
					return _res;
					
				case FAST_SCRIPT_CODE.YIELD :
					var _w	= _line[ FAST_SCRIPT_INDEX.DATA ].w;
					
					_lump.indent	= _line[ FAST_SCRIPT_INDEX.INDENT ];
					_lump.line		= _w == undefined || __is_false__( __eval__( _w, _lump )) ? _lump.line + 1 : _lump.line;
					_lump.state		= FAST_SCRIPT_YIELD;
					
					__Lump	= _lump;
					
					return _res;
					
				case FAST_SCRIPT_CODE.TEMP :
					var _w	= _line[ FAST_SCRIPT_INDEX.DATA ].w;
					var _i = 0; repeat( array_length( _w )) {
						__put__( _w[ _i ], _res[ _i ], _lump );
						
					}
					break;
					
				case FAST_SCRIPT_CODE.PUT :
					var _w	= _line[ FAST_SCRIPT_INDEX.DATA ].w;
					if ( is_array( _res )) {
						var _i = 0; repeat( array_length( _res )) {
							__put__( _w[ _i ], _res[ _i ], _lump );
							++_i;
						}
						
					} else {
						__put__( _w, _res, _lump );
						
					}
					break;
					
				case FAST_SCRIPT_CODE.LOAD :
					if ( is_string( _res ) == false )
						throw new InvalidArgumentType( "load", 0, _res, "string" );
					if ( file_exists( _res ) == false )
						throw new FileNotFound( "load", _res );
					
					var _file	= filename_name( _res );
					var _key	= _data.w;
					var _name	= filename_name( _file );
					var _dot	= string_pos( ".", _name );
					
					_name	= is_string( _key ) ? _key : string_copy( _name, 1, _dot == 0 ? string_length( _name ) : _dot - 1 );
					
					__put__( _name, new __Self__().from_input( new TextFile().open( _res )), _lump );
					
					break;
					
				case FAST_SCRIPT_CODE.EXECUTE : break; // already evaluated, for future expansion
				case FAST_SCRIPT_CODE.TRACE :
					FAST_SCRIPT_TRACE( strf("{1} line {2} : {0}", _res, __Source, _lump.last ) );
					break;
				
			}
			_indent	= _line[ FAST_SCRIPT_INDEX.INDENT ];
			_lump.line	+= 1;
			
		}
		throw new __Error__().from_string( "Script " + __Source + " ended in an unexpected way!" );
		
	}
	/// @param {string}	string	The string to use
	/// @desc	Converts the given string into an input which can be used to create a new script.
	static from_string	= function( _string ) {
		static __parser__	= new Parser();
		var _queue	= new Queue();
		
		if ( is_string( _string ) == false )
			throw new InvalidArgumentType( "Script.from_string", 0, _string, "string" );
		
		__parser__.open( _string );
		
		while( __parser__.finished() == false ) {
			var _read	= __parser__.word( char_is_linebreak, false );
			// discard blanks
			if ( _read == "" )
				continue;
			_queue.push( _read );
			
		}
		return from_input( _queue );
		
	}
	/// @param {__InputStream__}	input	The input to use
	/// @param {bool}				*close?	optional: Whether the input should be closed after
	///		reading. Default is true
	/// @desc	Takes the given input and reads from it to create a new script.
	static from_input	= function( _input, _close ) {
		static __keyword__	= function( _p ) {
			static __break__	= function( _p, _word ) {
				_p.mark();
				while( _p.finished() == false ) {
					_p.mark();
					if ( _p.word( char_is_whitespace, false ) == _word) {
						var _r	= _p.remaining();
						_p.reset();
						var _i	= _p.__Index;
						_p.reset();
						var _l	= _p.read( _i - _p.__Index );
						_p.remaining();
						
						return [ _l, _r ];
						
					}
					_p.unmark();
					
				}
				_p.reset();
				
				return [ _p.remaining(), "" ];
				
			}
			static __split_expression__	= function( _string ) {
				var _arr	= string_explode( _string, ",", false );
				var _i = 0; repeat( array_length( _arr )) {
					_arr[ _i ]	= expression_parse( _arr[ _i ] );
					++_i;
					
				}
				return _arr;
				
			}
			switch ( _p.read( char_is_whitespace, false ) ) {
				case "if"		: return {c: FAST_SCRIPT_CODE.IF, i: 1, e: {e: expression_parse( _p.remaining())}}
				case "else"		: return {c: FAST_SCRIPT_CODE.ELSE, i: 1, e: {e: _p.finished() ? true : expression_parse( _p.remaining())}};
				case "while"	: return {c: FAST_SCRIPT_CODE.WHILE, i: 1, e: {e: _p.finished() ? true : expression_parse( _p.remaining())}};
				case "return"	: return {c: FAST_SCRIPT_CODE.RETURN, i: 0, e: {e: _p.finished() ? undefined : expression_parse( _p.remaining())}};
				case "yield"	:
					var _t	= __break__( _p, "while" );
					var _e	= {e: undefined, w: undefined}
					
					_e.e	= _t[ 0 ] == "" ? undefined : expression_parse( _t[ 0 ] );
					_e.w	= _t[ 1 ] == "" ? undefined : expression_parse( _t[ 1 ] );
					
					return {c: FAST_SCRIPT_CODE.YIELD, i: 0, e: _e };
					
				case "temp"		:
					var _t	= __break__( _p, "as" );
					var _e	= {e: undefined, w: undefined}
					
					_e.w	= string_explode( _t[ 0 ], ",", true );
					
					if ( _t[ 1 ] != "" )
						_e.e	= __split_expression__( _t[ 1 ] );
					
					return {c: FAST_SCRIPT_CODE.TEMP, i: 0, e: _e };
					
				case "put"		:
					var _t	= __break__( _p, "into" );
					var _e	= {e: undefined, w: undefined}
					
					_e.e	= __split_expression__( _t[ 0 ] )
					_e.w	= string_explode( _t[ 1 ], ",", true );
					
					return {c: FAST_SCRIPT_CODE.PUT, i: 0, e: _e };
					
				case "load"		:
					var _t	= __break__( _p, "as" );
					var _e	= {e: undefined, w: undefined}
					
					_e.e	= expression_parse( _t[ 0 ] );
					
					if ( _t[ 1 ] != "" )
						_e.w	= string_trim( _t[ 1 ] );
					
					return {c: FAST_SCRIPT_CODE.LOAD, i: 0, e: _e };
					
				case "trace"	: return {c: FAST_SCRIPT_CODE.TRACE, i: 0, e: {e: expression_parse( _p.remaining())}};
				default:
					var _k	= _p.buffer();
					_p.mark();
					var _t	= _p.word( function( _c ) { return char_is_whitespace( _c ) || _c != "="; }, false );
					if ( _t == "=" ) {
						_p.unmark();
						return {c: FAST_SCRIPT_CODE.PUT, i: 0, e:{e: expression_parse( _p.remaining()), w: _k}}
						
					} else {
						_p.reset();
						
					}
					return undefined;
					
			}
			
		}
		// Function to return the length of the next read
		static __get_length__	= function( _p, _f ) {
			_p.mark();
			var _i = 0; while( _p.finished() == false ) {
				if ( _f( _p.read() ) == false )
					break;
				++_i;
			}
			_p.reset();
			
			return _i;
			
		}
		// Function to find the complimentary pair for a given character
		static __find_pair__	= function( _p, _c ) {
			_p.mark();
			var _i = 0; while ( _p.finished() == false ) {
				if ( _p.peek() == _c && _p.buffer() != "\\" )
					return _i + 1;
				_p.advance(1); ++_i;
			}
			_p.reset();
			
			throw new __Error__().from_string("Found " + _c + " without a closing " + _c + ".");
		
		}
		/// Function to retrieve the current indentation level
		static __get_indentation__	= function( _ind, _next ) {
			// if next indentation doesn't match last indentation
			if ( _next != _ind.peek() ) {
				// if the indentation is the same size, but different composition throw error
				if ( string_length( _next ) == string_length( _ind.peek()) )
					throw new __Error__().from_string( "Indentation length is the same, but does not match current level." );
				// if the indentation is larger than the current, set it as the new indentation
				if ( string_length( _next ) > string_length( _ind.peek()) ) {
					_ind.push( _next );
				// if the indentation is smaller than the current set, pop levels until match is
				// found, or scope runs out
				} else {
					while( _ind.size() > 1 ) {
						_ind.pop();
						
						if ( _ind.peek() == _next )
							return _ind.size();
						
					}
					throw new __Error__().from_string( "Indentation doesn't match previous scope." );
					
				}
				
			}
			return _ind.size();
			
		}
		// Function to trim right hand whitespace
		static __rtrim__	= function( _string ) {
			var _end	= string_length( _string );
			repeat ( _end ) {
				if ( not string_pos( string_char_at( _string, _end ), " \t" ) )
					break;
				_end--;
			}
			return string_copy( _string, 1, _end );
		}
		static __parser__	= new Parser();
		
		if ( struct_type( _input, __Stream__ ))
			_input	= new __Stream__( _input ).open();
		if ( struct_type( _input, __InputStream__ ) == false )
			throw new InvalidArgumentType( "Script.from_input", 0, _input, "__InputStream__" );
		
		var _output		= new LinkedList();
		var _indents	= new Stack().push( "" );
		var _stack		= new Stack().push([ 1, 0 ]);
		var _line		= 0;
		var _nextlevel	= 1;
		var _indent, _r;
		var _code, _exp;
		
		while( _input.finished() == false ) { ++_line;
			__parser__.open( __rtrim__( _input.read()) );
			// pull whitespace
			_r	= __parser__.read( char_is_whitespace );
			// discard comments
			if ( __parser__.peek( 2 ) == "//" ) { continue; }
			
		// # INDENTATION
			// get indentation level
			try { _indent	= __get_indentation__( _indents, _r ); }
			catch ( _ex ) {
				throw new BadScriptFormat( "BAD INDENTATION :: " + _ex.message, _input.__Source, _line, __parser__.__Content );
				
			}
			// if current indentation does not match expected next indenation
			if ( _nextlevel > 0 && _nextlevel != _indent ) {
				throw new BadScriptFormat( "BAD INDENTATION :: Expectated indentation to increase, but it did not.", _input.__Source, _line, __parser__.__Content );
				
			}
			_nextlevel	= 0;
			
		// # BRANCH HANDLING
			// if the indentation has changed, push the last indentation and line to the stack
			// we can use this to push the branch transfer
			if ( _indent > _stack.peek()[ 0 ] ) {
				_stack.push( [ _indent, _output.size() - 1 ] );
				
			// else if indentation has declined, pop the stack to find the new level
			} else if ( _indent < _stack.peek()[ 0 ] ) {
				while ( _stack.peek()[ 0 ] != _indent ) { _stack.pop(); }
				// write the current line to the last branch
				_output.index( _stack.peek()[ 1 ] )[@ 1 ] = _output.size();
				
				__parser__.mark();
				
				if ( __parser__.read( char_is_whitespace, false ) != "else" )
					array_push( __Jumpto, _output.size() );
				
				__parser__.reset();
				
			}
		// # WRITE OP CODES
			__parser__.mark();
			
			_code	= __keyword__( __parser__ );
			// no keyword, treat as expression
			if ( _code == undefined ) {
				__parser__.reset();
				
				_code	= FAST_SCRIPT_CODE.EXECUTE;
				_exp	= {e: expression_parse( __parser__.remaining() ), w: undefined }
				
			// otherwise write op code
			} else {
				__parser__.unmark();
				
				if ( _code.i > 0 ) { _nextlevel = _indent + _code.i; }
				_exp	= _code.e;
				_code	= _code.c;
				
			}
			_output.push([ _indent, undefined, _code, _exp, _line ]);
			
		}
		if ( _output.size() == 0 || _indent > 1 || _output.last()[ 2 ] != FAST_SCRIPT_CODE.RETURN ) {
			array_push( __Jumpto, _output.size() );
			_output.push([ 1, undefined, FAST_SCRIPT_CODE.RETURN, undefined, ++_line ]);
			
		}
		__Source	= _input.__Source;
		__Content	= _output.to_array();
		__Size		= array_length( __Content );
		
		_input.close();
		
		return self;
		
	}
	/// @param	{int}	ms	Time in ms to time out
	/// @desc	Sets the number of miliseconds after which a script will time out and throw an error. This
	///		is a generic protection against infinite loops, and can be disabled by setting ms to infinity.
	static timeout	= function( _value ) {
		__Timeout	= _value;
		
		return self;
		
	}
	/// @desc	Returns the number of lines in the script
	static size	= function() {
		return __Size;
		
	}
	/// @desc	Used for debugging scripts.  Dumps the bytecode to the output.
	static dump		= function() {
		var _i = 0; repeat( size() ) {
			var _line	= __Content[ _i++ ];
			show_debug_message( string_formatted("{: >3}: {}->{} {}", _line[ 4 ], _line[ 2 ], _line[ 1 ], _line[ 3 ] ));
			
		}
		show_debug_message( __Jumpto );
		
	}
	static toString	= function() {
		return __Source;
		
	}
	static __timer__	= new Timer();
	
	__Name		= ""
	__Jumpto	= [];
	__Size		= 0;
	__Lump		= undefined;
	__Content	= undefined;
	__UseLump	= false;
	__Global	= undefined;
	__Restrict	= undefined;
	__Timeout	= FAST_SCRIPT_DEFAULT_TIMEOUT;
	
	__Type__.add( Script );
	
}
