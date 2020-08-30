/// @func ScriptStatement
/// @param expression
function ScriptStatement( _expression ) constructor {
	static toString	= function() {
		return ( keyword != "" ? keyword : "" ) + ( target != undefined ? "(" + string( target ) + ") " : "" ) + ( expression != undefined ? string( expression ) : "" ) + ( goto != -1 ? " => " + "TRUE" : "" );// + " " + string( execute );
		
	}
	execute		= function( _engine, _package ) {
		if ( expression == undefined || expression.size() == 0 ) { return undefined; }
		
		return script_evaluate_expression( _engine, _package, expression );
		
	}
	var _parser	= ScriptManager().parser;
	var _keyword;
	// if/else/end, return, set
	_parser.parse( _expression );
	
	expression	= undefined;
	target		= undefined;
	ignore		= false;
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
		case "wait"		: ends = true; break;
		case "return"	: ends = true; break;
		case "loop"		: close= true; return;
		case "queue"	:
			execute	= function( _engine, _package ) {
				var _result	= _engine.scripts[? script_evaluate_expression( _engine, _package, expression ) ];
				
				if ( _result == undefined ) {
					_engine.log( "ScriptStatement", "Script ", _result, " not found. Skipped!" );
					
					return;
					
				}
				_engine.enqueue( _result );
				
			}
			break;
			
		case "push"		: 
			execute	= function( _engine, _package ) {
				var _result	= script_evaluate_expression( _engine, _package, expression );
				
				_engine.stack.push( _result );
				
			}
			break;
			
		case "set" :
			target	= _parser.next();
			
			_parser.next();
			
			execute	= function( _engine, _package ) {
				var _result	= script_evaluate_expression( _engine, _package, expression );
				
				script_evaluate_traverse_set( _engine, _package.local, target, _result );
				
			}
			break;
			
		default :
			_parser.reset();
			
			keyword	= "";
			
			break;
			
	}
	expression	= new ScriptExpression( string_delete( _expression, 1, _parser.last ) );
	
}