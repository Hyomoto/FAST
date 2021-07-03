/// @func ScriptExpression
function ScriptExpression( _string, _global ) constructor {
	static __pool__	= new ObjectPool(function() { return { left: undefined, right: undefined, parent: undefined, size: 0 } });
	static from_string	= function( _string ) {
		static __hash__ = 0;
		// look at the next char in expression
		static __next_char__ = function( _ex ) {
			if ( _ex.i > string_length( _ex.str ) )
				return undefined;
			return string_char_at( _ex.str, _ex.i++ );
		}
		// look at the current char in expression
		static __this_char__ = function( _ex ) {
			if ( _ex.i > string_length( _ex.str ) )
				return undefined;
			return string_char_at( _ex.str, _ex.i );
		}
		// look at the next l chars in expression
		static __memcmp__	= function( _ex, _l, _i ) {
			return string_copy( _ex.str, _ex.i + _i, _l );
		}
		static __insert_node__ = function( _current, _node, _flag) {
			if( _flag != FAST_SCRIPT_FLAG.SkipClimbUp ) {
				// step 4: climb up
				if( _flag != FAST_SCRIPT_FLAG.RightAssociative ) {
					// for left-associative
					while( _current.pre >= _node.pre )
						_current = _current.parent;
				} else {
					// for right-associative
					while( _current.pre > _node.pre )
						_current = _current.parent;
				}
			
			}
			if( _node.ID == FAST_SCRIPT_FLAG.CLOSEBRACKET ) {
				// step 5.1: remove the '(' node
				_node		= _current.parent;
				_node.right	= _current.right;
				//if ( _current.right != undefined )
				//	_current.right.parent = _node;
				with ( __pool__.put( _current.right ) ) {
					right.left		= undefined;
					right.right	= undefined;
					right.parent	= undefined;
				}
				// step 5.2: delete the '(' node
				_current.right	= undefined;
				// step 6: Set the '_current node' to be the parent node
				_current		= _node;
			
			} else {
				// step 5.1: create the new node
				_node.right = undefined;
				// step 5.2: add the new node
				_node.left = _current.right;
				if ( _current.right != undefined )
					_current.right.parent = _node;
			
				_current.right	= _node;
				_node.parent	= _current;
				// step 6: Set the '_current node' to be the new node
				_current		= _node;
			
			}
			return _current;
		
		}
		var i;
		var _c;
		var info;
		var previousID;
		var current;
		var root	= __pool__.get();
	
		if(_string=="") return undefined;
		_string = { str: _string, i: 1 }
		// Initialise the tree with the '(' node
		root.pre = 1;
		root.ID		= FAST_SCRIPT_FLAG.OPENBRACKET;
		previousID	= FAST_SCRIPT_FLAG.OPENBRACKET;
		current = root;
		// Do the expression parsing
		while( true ) {
			var node={ left: undefined, right: undefined, parent: undefined, number: 0 };
		
			info = FAST_SCRIPT_FLAG.NoInfo; // set info to default value
			node.pre = 10; // assume precedence is highest
		
			_c = __next_char__( _string ); // get latest character of string
		
			if(_c==undefined) break;  // if at the end of input string
		
			switch ( _c ) {
				case " " : case "\t" : case "\r" : case "\n" : continue;
				case "(" : node.ID = FAST_SCRIPT_FLAG.OPENBRACKET;  node.pre = 1; info = FAST_SCRIPT_FLAG.SkipClimbUp; break;
				case ")" : node.ID = FAST_SCRIPT_FLAG.CLOSEBRACKET; node.pre = 1; info = FAST_SCRIPT_FLAG.RightAssociative; break;
				case "+" :
					if(previousID == FAST_SCRIPT_FLAG.NUMBER
					|| previousID == FAST_SCRIPT_FLAG.VARIABLE
					|| previousID == FAST_SCRIPT_FLAG.STRING
					|| previousID == FAST_SCRIPT_FLAG.FUNCTION
					|| previousID == FAST_SCRIPT_FLAG.CLOSEBRACKET)
					     { node.ID = FAST_SCRIPT_FLAG.PLUS;     node.pre = 2; }
					else { node.ID = FAST_SCRIPT_FLAG.POSITIVE; node.pre = 3; info = FAST_SCRIPT_FLAG.SkipClimbUp; }
					break;
				case "-" :
					if(previousID == FAST_SCRIPT_FLAG.NUMBER
					|| previousID == FAST_SCRIPT_FLAG.VARIABLE
					|| previousID == FAST_SCRIPT_FLAG.STRING
					|| previousID == FAST_SCRIPT_FLAG.FUNCTION
					|| previousID == FAST_SCRIPT_FLAG.CLOSEBRACKET)
					     { node.ID = FAST_SCRIPT_FLAG.MINUS;    node.pre = 2; }
					else { node.ID = FAST_SCRIPT_FLAG.NEGATIVE; node.pre = 3; info = FAST_SCRIPT_FLAG.SkipClimbUp; }
					break;
				case "*" : node.ID = FAST_SCRIPT_FLAG.TIMES;     node.pre = 4; break;
				case "/" : node.ID = FAST_SCRIPT_FLAG.DIVIDE;    node.pre = 4; break;
				case "<" : node.ID = FAST_SCRIPT_FLAG.LESSTHAN;		 node.pre = 1.8; break;
				case ">" : node.ID = FAST_SCRIPT_FLAG.GREATERTHAN;	 node.pre = 1.8; break;
				case "\"":
					if(previousID == FAST_SCRIPT_FLAG.FUNCTION
					|| previousID == FAST_SCRIPT_FLAG.VARIABLE
					|| previousID == FAST_SCRIPT_FLAG.STRING
					|| previousID == FAST_SCRIPT_FLAG.NUMBER ) {
						throw new __Error__().from_string("Expected operator, but got script at position " + string( _string.i - 1 ) + " in " + _string.str + ".");
					}
					var _n = "";
					_c	= __next_char__(_string);
				
					while ( _c != "\"" ) {
						if ( _c == undefined ) { throw new __Error__().from_string( "Missing \" in string!" ); }
						_n += _c;
						_c	= __next_char__(_string );
					}
					node.ID	= FAST_SCRIPT_FLAG.STRING;
					node.number	= _n;
				
					break;
				default :
					var _two	= __memcmp__( _string, 2, -1 );
				
					if ( _two == "<=" ) {
						node.ID = FAST_SCRIPT_FLAG.LESSTHANOREQUAL;    node.pre = 1.8;
						_string.i += 1; break;
					} else if ( _two == ">=" ) {
						node.ID = FAST_SCRIPT_FLAG.GREATERTHANOREQUAL;    node.pre = 1.8;
						_string.i += 1; break;
					} else if ( _two == "==" ) {
						node.ID = FAST_SCRIPT_FLAG.EQUAL;    node.pre = 1.8;
						_string.i += 1; break;
					} else if ( _two == "!=" ) {
						node.ID = FAST_SCRIPT_FLAG.NOTEQUAL;    node.pre = 1.8;
						_string.i += 1; break;
					} else if ( __memcmp__( _string, 3, -1 ) == "and" ) {
						node.ID = FAST_SCRIPT_FLAG.AND;    node.pre = 1.4;
						_string.i += 2; break;
					} else if ( _two == "or" ) {
						node.ID = FAST_SCRIPT_FLAG.OR;    node.pre = 1.2;
						_string.i++; break;
					} else if ( _two == "0x" ) {
						_c = __next_char__(_string);
						var _n = "0"; while( true ) { _n += _c;
							static __HEX__ = "0123456789ABDEFabcdef"
							_c = __this_char__(_string);
							if ( _c != undefined && string_pos( _c, __HEX__ ) > 0 )
								_string.i++;
							else break;
						}
						node.number = real( _n );
						node.ID = FAST_SCRIPT_FLAG.NUMBER;
					
					} else if ( "0" <= _c && _c <= "9" ) {
						if(previousID == FAST_SCRIPT_FLAG.FUNCTION
						|| previousID == FAST_SCRIPT_FLAG.VARIABLE
						|| previousID == FAST_SCRIPT_FLAG.STRING
						|| previousID == FAST_SCRIPT_FLAG.NUMBER ) {
							throw new __Error__().from_string("Expected operator, but got number at position " + string( _string.i - 1 ) + " in " + _string.str + ".");
						}
					// numbers
						var _n = ""; while( true ) { _n += _c;
							_c = __this_char__(_string);
							if ( _c != undefined && ( "0" <= _c && _c <= "9" ) || _c=="." )
								_string.i++;
							else break;
						}
						node.number = real( _n );
						node.ID = FAST_SCRIPT_FLAG.NUMBER;
					
					} else if ( ( "A" <= _c && _c <= "Z" ) || ( "a" <= _c && _c <= "z" ) ) {
					// variables
						if(previousID == FAST_SCRIPT_FLAG.FUNCTION
						|| previousID == FAST_SCRIPT_FLAG.VARIABLE
						|| previousID == FAST_SCRIPT_FLAG.STRING
						|| previousID == FAST_SCRIPT_FLAG.NUMBER ) {
							throw new __Error__().from_string("Expected operator, but got variable at position " + string( _string.i - 1 ) + " in " + _string.str + ".");
						}
						var _start	= true;
					
						var _n = ""; while( true ) { _n += _c;
							_c = __this_char__(_string);
							if ( _c == ":" ) {
								var _m	="";
								var _s	= true;
								var _v	= [];
								_string.i++;
								if ( __this_char__(_string)!=":" ) {
									while( true ) {
									// functions
										_c = __this_char__(_string);
										// whitespace, push varname and break if chars were found
										if ( _c == " " || _c == "\t" ) {
											if ( _s == false ) {
												if ( _m != "" )
													array_push( _v, _m );
												break;
											} else {
												_string.i++;
												continue;
											}
										// strings
										} else if ( _c == "\"" ) {
											var _m = "";
											_string.i++;
											_c	= __next_char__(_string);
										
											while ( _c != "\"" ) {
												if ( _c == undefined ) { throw new __Error__().from_string( "Missing \" in argument string!" ); }
												_m += _c;
												_c	= __next_char__( _string );
											}
											array_push( _v, [ _m ] );
											_m = "";
											continue;
										// numbers
										} else if ( _s == true && "0" <= _c && _c <= "9" ) {
											_string.i++;
											while( true ) { _m += _c;
												_c = __this_char__(_string);
												if ( ( "0" <= _c && _c <= "9" ) || _c=="." )
													_string.i++;
												else break;
											}
											array_push( _v, real( _m ) );
											_m = "";
											continue;
										
										// comma, push varname and start over
										} else if ( _c == "," ) {
											if ( _m != "" )
												array_push( _v, _m );
											_m = "";
											_s = true;
											++_string.i;
											continue;
										// eol push varname and break
										} else if( ( _c < "0" || "9" < _c ) && ( _c < "A" || "Z" < _c ) && ( _c < "a" || "z" < _c ) && _c != "_" && _c != "." )
										|| _c == undefined || _c == "\n" {
											if ( _m != "" )
												array_push( _v, _m );
											break;
										}
										// char found, advance and start varname
										_string.i++;
										_m += _c;
										_s	= false;
								
									}
								
								} else {
									_string.i++;
								}
								node.ID		= FAST_SCRIPT_FLAG.FUNCTION;
								node.number	= _n;
								node.args	= _v;
								node.hash	= __hash__++
							
								break;
							
							} else if( ("0" <= _c && _c <= "9") || ( "A" <= _c && _c <= "Z" ) || ( "a" <= _c && _c <= "z" ) || _c == "_" || _c == "." ) {
								if ( _c == "_" && _start )
									throw new __Error__().from_string( "Variable names cannot start with ", _c, "!" );
								_string.i++;
								_start	= _c == ".";
							
							} else {
								if ( _n == "True" ) {
									node.number	= bool( true );
									node.ID		= FAST_SCRIPT_FLAG.NUMBER;
								
								} else if ( _n == "False" ) {
									node.number	= bool( false );
									node.ID		= FAST_SCRIPT_FLAG.NUMBER;
								
								} else if ( _n == "Null" ) {
									node.number	= undefined;
									node.ID		= FAST_SCRIPT_FLAG.NUMBER;
								
								} else {
									node.number	= _n;
									node.ID		= FAST_SCRIPT_FLAG.VARIABLE;
								
								}
								break;
							}
							
						}
						
					} else {
						throw new __Error__().from_string( "Unrecognized character " + _c + " at position " + string( _string.i -1 ) + "." );
						
					}
					break;
					
			}
			previousID = node.ID; // prepare for next iteration
			
			if ( node.ID != FAST_SCRIPT_FLAG.OPENBRACKET && node.ID != FAST_SCRIPT_FLAG.CLOSEBRACKET ) {
				root.size++;
			}
			current = __insert_node__(current, node, info);
			
		}
		// Finally remove the '(' node as a root node
		if( root.right != undefined ) root.right.parent = undefined;
		// then return the correct root node
		root.right.size	= root.size;
		
		__Node	= root.right;
		
		root.right	= undefined;
		__pool__.put( root );
		
		return self;
		
	}
	static evaluate	= function( _data ) {
		static __evaluate__	= function( _node, _data, _global, _eval_ ) {
			static __seek__	= function( _string, _data, _global ) {
				static	__parser	= new ( __FAST_script_config__().parser )(".");
				__parser.parse( _string );
				
				var _local	= _data.local;
				var _search, _scope;
				
				if ( _global == undefined || variable_struct_exists( _local, __parser.peek() )) { _search = _local; }
				else { _search = _global; }
				
				repeat( __parser.count() + 1 ) {
					_scope = _search;
					
					if ( is_undefined( _search ) )
						throw new __Error__().from_string("Variable not found!");
					_search = variable_instance_get( _search, __parser.next() );
					
					//if ( FAST_SCRIPT_PROTECT_FUNCTIONS && struct_type( _scope, ScriptFunctionWrapper ))
					//	throw new __Error__().from_string("Could not find " + _string + "!");
					
				}
				return is_method( _search ) ? method( _scope, _search ) : _search;
				
			}
			static __func__	= function( _seek, _hash, _func, _rargs, _data, _global ) {
				var _f		= _seek( _func, _data, _global );
				var _local	= _data.local;
				var _args	= array_create( array_length( _rargs ));
				
				var _i = -1; repeat( array_length( _args )) { ++_i;
					if ( is_numeric( _rargs[ _i ] ))
						_args[ _i ]	= _rargs[ _i ];
					else if ( is_array( _rargs[ _i ] ))
						_args[ _i ] = _rargs[ _i ][ 0 ];
					else
						_args[ _i ]	= _seek( _rargs[ _i ], _data, _global );
					
				}
				if ( _f == undefined )
					throw new __Error__().from_string( "Function " + string( _func ) + " not found!" );
				
				if ( struct_type( _f, Script )) {
					var _output, _h = false;
					// use coroutine if it exists
					if ( _data.coro[$ _hash ] != undefined ) {
						var _output	= _data.coro[$ _hash ].execute( _global );
						
						if ( _data.coro[$ _hash ].is_yielded() == false )
							variable_struct_remove( _data.coro, _hash );
						return _output;
						
					}
					switch ( array_length( _args ) ) {
						case 0 : _output = _f.execute( _global, undefined ); break;
						case 1 : _output = _f.execute( _global, undefined, _args[ 0 ] ); break;
						case 2 : _output = _f.execute( _global, undefined, _args[ 0 ], _args[ 1 ] ); break;
						case 3 : _output = _f.execute( _global, undefined, _args[ 0 ], _args[ 1 ], _args[ 2 ] ); break;
						case 4 : _output = _f.execute( _global, undefined, _args[ 0 ], _args[ 1 ], _args[ 2 ], _args[ 3 ] ); break;
						case 5 : _output = _f.execute( _global, undefined, _args[ 0 ], _args[ 1 ], _args[ 2 ], _args[ 3 ], _args[ 4 ] ); break;
					}
					if ( _output.state == FAST_SCRIPT_YIELD )
						_data.coro[$ _hash ] = new ScriptCoroutine( _f, _output );
					
					return _output.result;
					
				}
				if ( FAST_SCRIPT_PROTECT_FUNCTIONS && is_method( _f ) == false ) {
					if ( struct_type( _f, ScriptFunctionWrapper ) == false )
						throw new __Error__().from_string( "Function " + string( _func ) + " couldn't be called because FAST_SCRIPT_PROTECT_FUNCTIONS is on! Did you wrap your function in ScriptFunctionWrapper?" );
				}
				if ( struct_type( _f, ScriptFunctionWrapper ))
					_f	= _f.__Value;
					
				switch ( array_length( _args ) ) {
					case 0 : return _f();
					case 1 : return _f( _args[ 0 ] );
					case 2 : return _f( _args[ 0 ], _args[ 1 ] );
					case 3 : return _f( _args[ 0 ], _args[ 1 ], _args[ 2 ] );
					case 4 : return _f( _args[ 0 ], _args[ 1 ], _args[ 2 ], _args[ 3 ] );
					case 5 : return _f( _args[ 0 ], _args[ 1 ], _args[ 2 ], _args[ 3 ], _args[ 4 ] );
				}
				throw new __Error__().from_string( "Function " + string( _func ) + " couldn't be called because too many arguments were provided." );
				
			}
			if( is_struct( _node ) == false ) return _node;
			
			var left  = _eval_( _node.left, _data, _global, _eval_ );
			var right = _eval_( _node.right, _data, _global, _eval_ );
			
			switch( _node.ID ) {
				case FAST_SCRIPT_FLAG.POSITIVE:	return +right;
				case FAST_SCRIPT_FLAG.NEGATIVE:	return -right;
				case FAST_SCRIPT_FLAG.PLUS:		return left + right;
				case FAST_SCRIPT_FLAG.MINUS:	return left - right;
				case FAST_SCRIPT_FLAG.TIMES:	return left * right;
				case FAST_SCRIPT_FLAG.DIVIDE:	return left / right;
				case FAST_SCRIPT_FLAG.AND:		return left && right;
				case FAST_SCRIPT_FLAG.OR:		return left || right;
				case FAST_SCRIPT_FLAG.LESSTHAN:				return left < right;
				case FAST_SCRIPT_FLAG.GREATERTHAN:			return left > right;
				case FAST_SCRIPT_FLAG.GREATERTHANOREQUAL:	return left >= right;
				case FAST_SCRIPT_FLAG.LESSTHANOREQUAL:		return left <= right;
				case FAST_SCRIPT_FLAG.EQUAL:				return left == right;
				case FAST_SCRIPT_FLAG.NOTEQUAL:				return left != right;
				case FAST_SCRIPT_FLAG.VARIABLE:	return __seek__( _node.number, _data, _global );
				case FAST_SCRIPT_FLAG.FUNCTION: return __func__( __seek__, _node.hash, _node.number, _node.args, _data, _global );
				default:
					return _node.number;
			}
			
		}
		return __evaluate__( __Node, _data, __Global, __evaluate__ );
		
	}
	/// @desc	Destroy is not required to be called, but it will push all the nodes that make
	///		up the expression into the pool to be reused.  Thus it helps with memory management
	///		if you need to evaluate many expressions in the same frame.
	static destroy	= function() {
		static __destroy__	= function( _node, _destroy_ ) {
			if ( _node == undefined ) { return; }
			
			_destroy_( _node.left, _destroy_ );
			_destroy_( _node.right, _destroy_ );
			
			_node.left	= undefined;
			_node.right	= undefined;
			_node.parent	= undefined;
			
			__pool__.put( _node );
			
		}
		__destroy__( __Node, __destroy__ );
		
	}
	__Node		= undefined;
	__Global	= _global;
	
}
