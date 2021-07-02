/// @func DatabaseExpression
function DatabaseExpression( _string, _global ) constructor {
	static __pool__	= new ObjectPool(function() { return { left: undefined, right: undefined, parent: undefined, size: 0 } });
	static from_string	= function( _string ) {
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
					|| previousID == FAST_SCRIPT_FLAG.CLOSEBRACKET)
					     { node.ID = FAST_SCRIPT_FLAG.PLUS;     node.pre = 2; }
					else { node.ID = FAST_SCRIPT_FLAG.POSITIVE; node.pre = 3; info = FAST_SCRIPT_FLAG.SkipClimbUp; }
					break;
				case "-" :
					if(previousID == FAST_SCRIPT_FLAG.NUMBER
					|| previousID == FAST_SCRIPT_FLAG.VARIABLE
					|| previousID == FAST_SCRIPT_FLAG.STRING
					|| previousID == FAST_SCRIPT_FLAG.CLOSEBRACKET)
					     { node.ID = FAST_SCRIPT_FLAG.MINUS;    node.pre = 2; }
					else { node.ID = FAST_SCRIPT_FLAG.NEGATIVE; node.pre = 3; info = FAST_SCRIPT_FLAG.SkipClimbUp; }
					break;
				case "*" : node.ID = FAST_SCRIPT_FLAG.TIMES;     node.pre = 4; break;
				case "/" : node.ID = FAST_SCRIPT_FLAG.DIVIDE;    node.pre = 4; break;
				case "<" : node.ID = FAST_SCRIPT_FLAG.LESSTHAN;		 node.pre = 1.8; break;
				case ">" : node.ID = FAST_SCRIPT_FLAG.GREATERTHAN;	 node.pre = 1.8; break;
				case "\"": case "'":
					if(previousID == FAST_SCRIPT_FLAG.VARIABLE
					|| previousID == FAST_SCRIPT_FLAG.STRING
					|| previousID == FAST_SCRIPT_FLAG.NUMBER ) {
						throw new __Error__().from_string("Expected operator, but got script at position " + string( _string.i - 1 ) + " in " + _string.str + ".");
					}
					var _n = "", _p = _c;
					_c	= __next_char__(_string);
					
					while ( _c != _p ) {
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
						if(previousID == FAST_SCRIPT_FLAG.VARIABLE
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
					
					} else if ( ( "A" <= _c && _c <= "Z" ) || ( "a" <= _c && _c <= "z" )  || _c == "@" ) {
					// variables
						if(previousID == FAST_SCRIPT_FLAG.VARIABLE
						|| previousID == FAST_SCRIPT_FLAG.STRING
						|| previousID == FAST_SCRIPT_FLAG.NUMBER ) {
							throw new __Error__().from_string("Expected operator, but got variable at position " + string( _string.i - 1 ) + " in " + _string.str + ".");
						}
						var _start	= true;
					
						var _n = ""; while( true ) { _n += _c;
							_c = __this_char__(_string);
							if( ("0" <= _c && _c <= "9") || ( "A" <= _c && _c <= "Z" ) || ( "a" <= _c && _c <= "z" ) || _c == "_" || _c == "." ) {
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
						throw new __Error__().from_string( "Unrecognised character " + _c + " at position " + string( _string.i -1 ) + "." );
						
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
	static evaluate	= function( _local, _db ) {
		static __evaluate__	= function( _node, _local, _db, _eval_ ) {
			if( is_struct( _node ) == false ) return _node;
			
			var left  = _eval_( _node.left, _local, _eval_ );
			var right = _eval_( _node.right, _local, _eval_ );
			
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
				case FAST_SCRIPT_FLAG.VARIABLE:
					if ( string_char_at( _node.number, 1 ) == "@" ) { return _local[$ string_delete( _node.number, 1, 1 ) ]; }
					return _db.read( _node.number );
				default:
					return _node.number;
			}
			
		}
		return __evaluate__( __Node, _local, _db, __evaluate__ );
		
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
	
}
