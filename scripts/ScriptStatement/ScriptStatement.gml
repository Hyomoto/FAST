/// @func ScriptStatement
/// @param expression
function ScriptStatement( _expression ) constructor {
	//static toString	= function() {
	//	return ( keyword != "" ? keyword : "" ) + ( target != undefined ? "(" + string( target ) + ") " : "" ) + ( expression != undefined ? string( expression ) : "" ) + " " + string( execute );
		
	//}
	execute		= function( _engine, _local ) {
		if ( expression.size() == 0 ) { return undefined; }
		
		return script_evaluate_expression( _engine, _local, expression );
		
	}
	var _parser	= ScriptManager().parser;
	var _keyword;
	// if/else/end, return, set
	_parser.parse( _expression );
	
	expression	= undefined;
	target		= undefined;
	local		= false;
	open		= false;
	close		= false;
	ends		= false;
	depth		= -1;
	goto		= -1;
	
	_keyword	= _parser.next();
	
	if ( _keyword == "var" ) {
		local	= true;
		
		_keyword	= _parser.next();
		
	}
	keyword		= _keyword;
	
	switch ( _keyword ) {
		case "if"		: open = true; break;
		case "else"		: _parser.parse( "1" ); _expression = "1";
		case "elseif"	: close= true; open = true; break;
		case "end"		: close= true; return;
		case "return"	: ends = true; break;
		case "set" :
			target	= _parser.next();
			
			_parser.next();
			
			execute	= function( _engine, _local ) {
				var _result	= script_evaluate_expression( _engine, _local, expression );
				
				if ( variable_struct_exists( _local, target ) || local ) {
					variable_struct_set( _local, target, _result );
					
				} else {
					_engine.set_value( target, _result );
					
				}
				
			}
			break;
			
		default :
			_parser.reset();
			
			keyword	= "";
			
			break;
			
	}
	expression	= new ScriptExpression( string_delete( _expression, 1, _parser.last ) );
	
}
