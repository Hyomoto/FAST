/// @func script_evaluate_expression
/// @param engine
/// @param local
/// @param ScriptExpression
function script_evaluate_expression( _engine, _local, _expression ) {
	function __script_evaluate_next( _engine, _local, _ex ) {
		var _next	= _ex.next();
		
		if ( instanceof( _next ) == "ScriptExpression" ) {
			return script_evaluate_expression( _engine, _local, _next );
			
		}
		if ( _next.type == SCRIPT_EXPRESSION_TYPE_OPERAND && _next.rao ) {
			return _next.execute( __script_evaluate_next( _engine, _local, _ex ) );
			
		}
		return _next.get( _engine, _local );
		
	}
	static __manager	= ScriptManager();
	var _prec	= 0;	// operator precedence
	var _left, _right, _next;
	
	_expression.start();
	
	_left	= __script_evaluate_next( _engine, _local, _expression );	// seed left
	
	while ( _expression.has_next() ) {
		_next	= _expression.next();
		_left	= _next.execute( _left, __script_evaluate_next( _engine, _local, _expression ) );
		
	}
	return _left;
	
}
