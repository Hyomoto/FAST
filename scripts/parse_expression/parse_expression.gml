/// @func parse_expression
/// @param {string}	expression	A string expression
/// @desc	Converts the given expression into a binary expression tree which can then be evaluated using
///		evaluate_expression
/// @returns struct
function parse_expression( expression ) {
	static __hash__ = 0
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
			if ( _current.right != undefined )
				_current.right.parent = _node;
			
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
	var root={ left: undefined, right: undefined, parent: undefined, size: 0 };
	
	if(expression=="") return undefined;
	expression = { str: expression, i: 1 }
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
		
		_c = __next_char__( expression ); // get latest character of string
		
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
					throw new __Error__().from_string("Expected operator, but got script at position " + string( expression.i - 1 ) + " in " + expression.str + ".");
				}
				var _n = "";
				_c	= __next_char__(expression);
				
				while ( _c != "\"" ) {
					if ( _c == undefined ) { throw new __Error__().from_string( "Missing \" in string!" ); }
					_n += _c;
					_c	= __next_char__(expression );
				}
				node.ID	= FAST_SCRIPT_FLAG.STRING;
				node.number	= _n;
				
				break;
			default :
				var _two	= __memcmp__( expression, 2, -1 );
				
				if ( _two == "<=" ) {
					node.ID = FAST_SCRIPT_FLAG.LESSTHANOREQUAL;    node.pre = 1.8;
					expression.i += 1; break;
				} else if ( _two == ">=" ) {
					node.ID = FAST_SCRIPT_FLAG.GREATERTHANOREQUAL;    node.pre = 1.8;
					expression.i += 1; break;
				} else if ( _two == "==" ) {
					node.ID = FAST_SCRIPT_FLAG.EQUAL;    node.pre = 1.8;
					expression.i += 1; break;
				} else if ( _two == "!=" ) {
					node.ID = FAST_SCRIPT_FLAG.NOTEQUAL;    node.pre = 1.8;
					expression.i += 1; break;
				} else if ( __memcmp__( expression, 3, -1 ) == "and" ) {
					node.ID = FAST_SCRIPT_FLAG.AND;    node.pre = 1.4;
					expression.i += 2; break;
				} else if ( _two == "or" ) {
					node.ID = FAST_SCRIPT_FLAG.OR;    node.pre = 1.2;
					expression.i++; break;
				} else if ( _two == "0x" ) {
					_c = __next_char__(expression);
					var _n = "0"; while( true ) { _n += _c;
						static __HEX__ = "0123456789ABDEFabcdef"
						_c = __this_char__(expression);
						if ( _c != undefined && string_pos( _c, __HEX__ ) > 0 )
							expression.i++;
						else break;
					}
					node.number = real( _n );
					node.ID = FAST_SCRIPT_FLAG.NUMBER;
					
				} else if ( "0" <= _c && _c <= "9" ) {
					if(previousID == FAST_SCRIPT_FLAG.FUNCTION
					|| previousID == FAST_SCRIPT_FLAG.VARIABLE
					|| previousID == FAST_SCRIPT_FLAG.STRING
					|| previousID == FAST_SCRIPT_FLAG.NUMBER ) {
						throw new __Error__().from_string("Expected operator, but got number at position " + string( expression.i - 1 ) + " in " + expression.str + ".");
					}
				// numbers
					var _n = ""; while( true ) { _n += _c;
						_c = __this_char__(expression);
						if ( _c != undefined && ( "0" <= _c && _c <= "9" ) || _c=="." )
							expression.i++;
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
						throw new __Error__().from_string("Expected operator, but got variable at position " + string( expression.i - 1 ) + " in " + expression.str + ".");
					}
					var _start	= true;
					
					var _n = ""; while( true ) { _n += _c;
						_c = __this_char__(expression);
						if ( _c == ":" ) {
							var _m	="";
							var _s	= true;
							var _v	= [];
							expression.i++;
							if ( __this_char__(expression)!=":" ) {
								while( true ) {
								// functions
									_c = __this_char__(expression);
									// whitespace, push varname and break if chars were found
									if ( _c == " " || _c == "\t" ) {
										if ( _s == false ) {
											if ( _m != "" )
												array_push( _v, _m );
											break;
										} else {
											expression.i++;
											continue;
										}
									// strings
									} else if ( _c == "\"" ) {
										var _m = "";
										expression.i++;
										_c	= __next_char__(expression);
										
										while ( _c != "\"" ) {
											if ( _c == undefined ) { throw new __Error__().from_string( "Missing \" in argument string!" ); }
											_m += _c;
											_c	= __next_char__( expression );
										}
										array_push( _v, [ _m ] );
										_m = "";
										continue;
									// numbers
									} else if ( _s == true && "0" <= _c && _c <= "9" ) {
										expression.i++;
										while( true ) { _m += _c;
											_c = __this_char__(expression);
											if ( ( "0" <= _c && _c <= "9" ) || _c=="." )
												expression.i++;
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
										++expression.i;
										continue;
									// eol push varname and break
									} else if( ( _c < "0" || "9" < _c ) && ( _c < "A" || "Z" < _c ) && ( _c < "a" || "z" < _c ) && _c != "_" && _c != "." )
									|| _c == undefined || _c == "\n" {
										if ( _m != "" )
											array_push( _v, _m );
										break;
									}
									// char found, advance and start varname
									expression.i++;
									_m += _c;
									_s	= false;
								
								}
								
							} else {
								expression.i++;
							}
							node.ID		= FAST_SCRIPT_FLAG.FUNCTION;
							node.number	= _n;
							node.args	= _v;
							node.hash	= __hash__++
							
							break;
							
						} else if( ("0" <= _c && _c <= "9") || ( "A" <= _c && _c <= "Z" ) || ( "a" <= _c && _c <= "z" ) || _c == "_" || _c == "." ) {
							if ( _c == "_" && _start )
								throw new __Error__().from_string( "Variable names cannot start with ", _c, "!" );
							expression.i++;
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
					throw new __Error__().from_string( "Unrecognized character " + _c + " at position " + string( expression.i -1 ) + "." );
					
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
	root.right.toString = method( root.right, function() {
		return print_expression( self );
	});
	
	return root.right;
	
}
