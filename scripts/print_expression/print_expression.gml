/// @func print_expression
function print_expression( _node ) {
	static __print__	= function( _print, _node, _str ) {
		var str;
		if( _node == undefined) return _str;
		
		_str = _print( _print, _node.left, _str );  /* print left sub-tree */
		
		switch( _node.ID) /* prepare to print current node */
		{
			case FAST_SCRIPT_FLAG.NUMBER:		
			case FAST_SCRIPT_FLAG.STRING:		
			case FAST_SCRIPT_FLAG.VARIABLE:		str = string( _node.number ); break;
			case FAST_SCRIPT_FLAG.OPENBRACKET:	str = "(";   break;
			case FAST_SCRIPT_FLAG.POSITIVE:		str = "+ve"; break;
			case FAST_SCRIPT_FLAG.NEGATIVE:		str = "-ve"; break;
			case FAST_SCRIPT_FLAG.PLUS:			str = "+";   break;
			case FAST_SCRIPT_FLAG.MINUS:		str = "-";   break;
			case FAST_SCRIPT_FLAG.TIMES:		str = "*";   break;
			case FAST_SCRIPT_FLAG.DIVIDE:		str = "/";   break;
			case FAST_SCRIPT_FLAG.AND:			str = "and"; break;
			case FAST_SCRIPT_FLAG.OR:			str = "or";  break;
			case FAST_SCRIPT_FLAG.LESSTHAN:				str = "less than";   break;
			case FAST_SCRIPT_FLAG.GREATERTHAN:			str = "greater than";   break;
			case FAST_SCRIPT_FLAG.GREATERTHANOREQUAL:	str = "greater than or equal";   break;
			case FAST_SCRIPT_FLAG.LESSTHANOREQUAL:		str = "less than or equal";   break;
			case FAST_SCRIPT_FLAG.EQUAL:				str = "equal";   break;
			case FAST_SCRIPT_FLAG.NOTEQUAL:				str = "not equal";   break;
			case FAST_SCRIPT_FLAG.FUNCTION:		str = _node.number + string( _node.args ); break;
			default:							str = "error";
		}
		_str	+= " " + str + " ";
		
		return _print( _print, _node.right, _str );   /* print right sub-tree */
		
	}
	return __print__( __print__, _node, "" );
	
}