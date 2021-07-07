/// @func expression_parse
/// @param {string}	expression	A string expression
/// @desc	Converts the given expression into a binary expression tree which can then be evaluated using
///		evaluate_expression
/// @returns struct
function expression_parse( _string ) {
	static __pool__	= new ObjectPool();
	// An expression tree node
	static __node__	= function( _l, _r, _v, _p ) constructor {
		static toString	= function() {
			var _r	= "";
			
			if ( left != undefined ) { _r += left.toString(); }
			_r	+= is_method( value ) ? value.op : string( value );
			if ( right!= undefined ) { _r += right.toString(); }
			
			return _r;
			
		}
		static	evaluate	= function( _lookup, _lump ) {
			static __execute_func__	= function( _func, _args ) {
				switch ( array_length( _args )) {
					case 0 : return _func();
					case 1 : return _func( _args[ 0 ]);
					case 2 : return _func( _args[ 0 ], _args[ 1 ]);
					case 3 : return _func( _args[ 0 ], _args[ 1 ], _args[ 2 ]);
					case 4 : return _func( _args[ 0 ], _args[ 1 ], _args[ 2 ], _args[ 3 ]);
					case 5 : return _func( _args[ 0 ], _args[ 1 ], _args[ 2 ], _args[ 3 ], _args[ 4 ]);
					default: return _func( _args[ 0 ], _args[ 1 ], _args[ 2 ], _args[ 3 ], _args[ 4 ], _args[ 5 ]);
					
				}
				
			}
			// Function to extract the scope of the key base
			static __get_scope__	= function( _lookup, _key ) {
				var _scope, _i = 0; repeat( array_length( _lookup )) {
					if ( variable_instance_exists( _lookup[ _i ], _key ))
						return _lookup[ _i ];
					++_i;
				}
				// value couldn't be looked up
				throw new ValueNotFound("evaluate", _key, -1 );
				
			}
			// Function to return the function piece of a function value
			static __get_func__	= function( _a ) { return _a[ 0 ]; }
			// Function to return the hash piece of a function value
			static __get_hash__	= function( _a ) { return _a[ 1 ]; }
			
			if ( is_method( value ))
				return value( left.evaluate( _lookup ), right.evaluate( _lookup ));
			if ( is_real( value ))
				return value;
			if ( is_array( value ))
				__parser__.parse( __get_func__( value ) );
			else if ( string_pos( string_char_at( value, 1 ), "\"'" ) > 0 ) // inefficient but fix later
				return string_copy( value, 2, string_length( value ) - 2 );
			else
				__parser__.parse( value );
			
			if ( is_array( _lookup ) == false ) { _lookup = [ _lookup ]; }
			var _key	= __parser__.next();
			
			var _scope	= __get_scope__( _lookup, _key );
			repeat( __parser__.count() ) {
				_scope	= variable_instance_get( _scope, _key );
				_key	= __parser__.next();
				
			}
			// this is a function
			if ( is_array( value )) {
				var _func	= _scope[$ _key ];
				var _args	= array_create( array_length( value ) - 2);
				
				var _i = 0; repeat( array_length( _args ) ) {
					_args[ _i ]	= value[ _i + 2 ].evaluate( _lookup );
					++_i;
				}
				// handle scripts
				if ( struct_type( _func, Script )) {
					var _hash	= value[ 1 ];
					var _coro	= _lump.coro[$ _hash ];
					
					// handle coroutines
					if ( _coro != undefined ) {
						var _output	= _coro.execute();
						
						if ( _coro.is_yielded() == false )
							variable_struct_remove( _lump.coro, _hash );
						
						return _output;
						
					}
					// handle scripts
					if ( array_length( _lookup ) > 1 )
						_func.use_global( _lookup[ 1 ] );
					var _output	= __execute_func__( method( _func, _func.execute ), _args )
					
					if ( _func.__Lump.state == FAST_SCRIPT_YIELD )
						_lump.coro[$ _hash ]	= new ScriptCoroutine( _func, _func.__Lump );
					
					return _output;
					
				}
				if ( FAST_SCRIPT_PROTECT_FUNCTIONS && is_method( _func ) == false ) {
					throw new __Error__().from_string( "Function " + string( _key ) + " couldn't be called because it is unsafe. Functions must be bound as methods." );
					
				}
				// fixes error with rebinding runtime functions that were already bound
				var _method	= method( _scope, _func);
				if ( _method == undefined ) { _method = _func; }
				
				// handle methods
				return __execute_func__( _method, _args );
				
			}
			// handle values
			return _scope[$ _key ];
			
		}
		// Function to dispose of the expression.  Not strictly required, but will free the nodes
		// to the object pool for reuse, reducing memory use in some cases.
		static destroy	= function() {
			if ( left  != undefined ) { left.destroy(); left = undefined; }
			if ( right != undefined ) { right.destroy();right= undefined; }
			value	= undefined;
			
			__pool__.put( self );
			
		}
		static __parser__	= new ( __FAST_script_config__().parser )(".");
		static __pool__		= _p;
		
		value	= _v;
		left	= _l;
		right	= _r;
		
	}
	// Function to find precedence of operators.
	static __precedence__	= function( _op ) {
		switch ( _op ) {
			case "+" : case "-" : return 2;
			case "*" : case "/" : return 4;
			case "<" : case ">" : case "<=": case ">=": case "==": case "!=": return 1.8;
			case "&&": return 1.4;
			case "||": return 1.2;
		}
	    return 0;
		
	}
	static __char_is_variable__	= function( _c ) {
		return char_is_english( _c ) || _c == "_" || _c == ".";
		
	}
	static __seek_pair__	= function( _p, _c ) {
		var _i = 0; while ( _p.finished() == false ) {
			if ( _p.peek() == _c && _p.buffer() != "\\" )
				return _i + 1;
			_p.read(); ++_i;
		}
		throw new __Error__().from_string("Found " + _c + " without a closing " + _c + ".");
		
	}
	// Function to perform arithmetic operations.
	static __get_operation__	= function( _op ) {
		static __add__	= ( function() { var _f	= function( _a, _b ) { return _a + _b; }; _f.op	= "+"; return _f; })();
		static __sub__	= ( function() { var _f	= function( _a, _b ) { return _a - _b; }; _f.op	= "-"; return _f; })();
		static __mul__	= ( function() { var _f	= function( _a, _b ) { return _a * _b; }; _f.op	= "*"; return _f; })();
		static __div__	= ( function() { var _f	= function( _a, _b ) { return _a / _b; }; _f.op	= "/"; return _f; })();
		static __lt__	= ( function() { var _f	= function( _a, _b ) { return _a < _b; }; _f.op	= "<"; return _f; })();
		static __gt__	= ( function() { var _f	= function( _a, _b ) { return _a > _b; }; _f.op	= ">"; return _f; })();
		static __lte__	= ( function() { var _f	= function( _a, _b ) { return _a <= _b; }; _f.op= "<="; return _f; })();
		static __gte__	= ( function() { var _f	= function( _a, _b ) { return _a >= _b; }; _f.op= ">="; return _f; })();
		static __eq__	= ( function() { var _f	= function( _a, _b ) { return _a == _b; }; _f.op= "=="; return _f; })();
		static __neq__	= ( function() { var _f	= function( _a, _b ) { return _a != _b; }; _f.op= "!="; return _f; })();
		static __and__	= ( function() { var _f	= function( _a, _b ) { return _a && _b; }; _f.op= "&&"; return _f; })();
		static __or__	= ( function() { var _f	= function( _a, _b ) { return _a || _b; }; _f.op= "||"; return _f; })();
		
	    switch ( _op ) {
			case "+" : return __add__;
			case "-" : return __sub__;
			case "*" : return __mul__;
			case "/" : return __div__;
			case "<" : return __lt__;
			case ">" : return __gt__;
			case "<=" : return __lte__;
			case ">=" : return __gte__;
			case "==" : return __eq__;
			case "!=" : return __neq__;
			case "&&" : return __and__;
			case "||" : return __or__;
		}
		throw new __Error__().from_string( "Expression evaluation failed, no operation found for " + string( _op ) + "." );
		
	}
	static make	= function( _l, _r, _v, _pool, _node ) {
		var _n;
		
		if ( _pool.is_empty() ) {
			_n	= new _node( _l, _r, _v, _pool );
			
		} else {
			_n	= _pool.get();
			_n.left		= _l;
			_n.right	= _r;
			_n.value	= _v;
			
		}
		return _n;
		
	}
	static __parser__	= new Parser();
	static __values__	= new Stack();
	static __ops__		= new Stack();
	
	if ( _string == "" )
		throw new InvalidArgumentType( "expression_parse", 0, _string, "expression" );
	
	__parser__.open( _string );
	
	while ( __parser__.finished() == false ) {
		var _c	= __parser__.read();
	    // Current token is a whitespace, skip it.
	    if ( _c == " " || _c == "\t" ) {
			continue;
			
		} else if ( _c == "(" ) {
	    // Current token is an opening brace, push it to 'ops'
	        __ops__.push( _c );
			
		} else if ( char_is_numeric( _c )) {
			// Current token is a number, push it to stack for numbers.
	        __parser__.unread().mark();
			
			if ( __parser__.peek(2) == "0x" ) { _i += 2; __parser__.advance(2); }
	        // There may be more than one digits in the number.
	        var _i = 0; while ( __parser__.finished() == false ) {
				if ( char_is_numeric( __parser__.read()) == false )
					break;
	            ++_i;
			}
			__parser__.reset();
			
			__values__.push( make( undefined, undefined, real( __parser__.read( _i )), __pool__, __node__ ) );
            
		} else if ( _c == "\"" || _c == "'" ) {
			__parser__.mark();
			
			var _i	= __seek_pair__( __parser__, _c );
			
			__parser__.reset();
			
			__values__.push( make( undefined, undefined, _c + __parser__.read( _i ), __pool__, __node__ ) );
            
		} else if ( char_is_english( _c )) {
			static __hash__	= 0;
			// Current token is a number, push it to stack for numbers.
	        __parser__.unread().mark();
			
	        // There may be more than one digits in the number.
	        var _i = 0; while ( __parser__.finished() == false ) {
				if ( __parser__.peek() == "(" ) { // function
					
					__parser__.push();
					__parser__.reset();
					
					var _exp	= [ __parser__.read(_i), string( __hash__++ ) ];
					
					var _j = 0, _b = 0; while( __parser__.finished() == false ) {
						var _c	= __parser__.read();
						
						if ( _c == "(" ) {
							++_b;
						
						} else if ( _c == "\"" ) {
							_j	+= __seek_pair__( __parser__, _c );
							
						} else if ( _c == "," && _b == 1 ) {
							__parser__.pop().advance(1);
							
							_c	= __parser__.read( _j - 1 );
							
							__parser__.push();
							
							array_push( _exp, expression_parse( _c ));
							
							__parser__.pop().push().advance(1);
							
							_j	= 0;
							
						} else if ( _c == ")" ) {
							if ( --_b == 0 ) { break; }
							
						}
						++_j;
						
					}
					__parser__.pop().advance(1);
					
					_c	= __parser__.read( _j - 1 );
					
					__parser__.advance(1).push();
					
					if ( _c != "" ) {
						array_push( _exp, expression_parse( _c ) );
						
					}
					__parser__.pop();
					
					__values__.push( make( undefined, undefined, _exp, __pool__, __node__ ) );
					
					break;
					
				}
				if ( __char_is_variable__( __parser__.read()) == false )
					break;
	            ++_i;
			}
			// this is a hack, but some way is needed to know when an expression has been used
			// when the function finishes, it does not remark, thus reset would fail and we know
			// this section has been parsed
			if ( __parser__.__Level > -1 ) {
				__parser__.reset();
				
				var _v; switch ( __parser__.read( _i )) {
					case "True"		: _v = 1; break;
					case "False"	: _v = 0; break;
					case "Null"		: _v = undefined; break;
					default			: _v = __parser__.buffer();
					
				}
				__values__.push( make( undefined, undefined, _v, __pool__, __node__ ) );
            
			}
		
		} else if ( _c == ")" ) {
			// Closing brace encountered, solve entire brace.
			while ( __ops__.size() > 0 && __ops__.peek() != "(" ) {
				var _v2	= __values__.pop();
				var _v1	= __values__.pop();
				var _op	= __get_operation__( __ops__.pop());
				
				__values__.push( make( _v1, _v2, _op, __pool__, __node__ ) );
				
			}
	        __ops__.pop();
			
		} else {
			// Current token is an operator.
	        // While top of 'ops' has same or greater precedence to current token, which is
			// an operator. Apply operator on top of 'ops' to top two elements in values stack.
			while( __ops__.size() > 0 && __precedence__( __ops__.peek() ) >= __precedence__( _c )) {
				var _v2	= __values__.pop();
				var _v1	= __values__.pop();
				var _op	= __get_operation__( __ops__.pop());
				
				__values__.push( make( _v1, _v2, _op, __pool__, __node__ ) );
				
			}
	        // Push current token to 'ops'.
			__parser__.unread();
			// dual operators
			if ( __precedence__( __parser__.peek(2) ) > 0) {
				__ops__.push( __parser__.peek( 2 ));
				__parser__.advance( 2 );
			// single operators
			} else if ( __precedence__( _c ) > 0) {
				//if ( _c == "+" || _c == "-" ) && __precedence__( __ops__.peek() ) > 0 )
				__ops__.push( _c );
				__parser__.advance(1);
				
			// operator not found
			} else {
				throw new __Error__().from_string( "Expression evaluation failed, no operation found for " + string( _c ) + "." );
				
			}
			
		}
	    
	}
	// Entire expression has been parsed at this point, apply remaining ops to remaining values.
	while( __ops__.size() > 0 ) {
	    var _v2	= __values__.pop();
		var _v1	= __values__.pop();
		var _op	= __get_operation__( __ops__.pop());
		
		__values__.push( make( _v1, _v2, _op, __pool__, __node__ ) );
		
	}
	// Top of 'values' contains result, return it.
	return __values__.pop();
	
}
