/// @func evaluate_expression
/// @param {struct}	node	A binary expression tree from parse_expression
/// @param {struct}	vars	A struct containing seekable variables
/// @desc	Evaluates the given expression node using vars as a lookup table.
/// @returns mixed
function evaluate_expression( _node, _data, _global ) {
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
	var left, right;
	if( is_struct( _node ) == false ) return _node;
	
	left  = evaluate_expression( _node.left, _data, _global );
	right = evaluate_expression( _node.right, _data, _global );
	
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
