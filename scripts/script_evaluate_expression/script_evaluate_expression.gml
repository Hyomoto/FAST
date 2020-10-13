/// @func script_evaluate_expression
/// @param engine
/// @param local
/// @param ScriptExpression
/// @wiki Scripting-Index
function script_evaluate_expression( _engine, _package, _expression ) {
	function __script_evaluate_next( _engine, _package, _ex ) {
		var _next	= _ex.next();
		
		if ( instanceof( _next ) == "ScriptExpression" ) {
			return script_evaluate_expression( _engine, _package, _next );
			
		}
		if ( _next.type == SCRIPT_EXPRESSION_TYPE_OPERAND && _next.rao ) {
			return _next.execute( __script_evaluate_next( _engine, _package, _ex ) );
			
		}
		return _next.get( _engine, _package );
		
	}
	static __manager	= ScriptManager();
	
	var _left, _next;
	
	_expression.start();
	
	_left	= __script_evaluate_next( _engine, _package, _expression );	// seed left
	
	while ( _expression.has_next() ) {
		_next	= _expression.next();
		_left	= _next.execute( _left, __script_evaluate_next( _engine, _package, _expression ) );
		
	}
	return _left;
	
}
