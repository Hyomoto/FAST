/// @func expression_evaluate
/// @param {mixed}	expression	The expression to evaluate.
/// @param {struct}	*lookup		optional: A struct to look up values in.
/// @desc	Evaluates the given expression.  If expression is a string, it will have to be converted
///		first.
function expression_evaluate( _expression, _lookup ) {
	if ( is_string( _expression ))
		_expression	= expression_parse( _expression );
	if ( is_struct( _expression ) == false )
		throw InvalidArgumentType( "expression_evaluate", 0, _expression, "string" );
	return _expression.evaluate( _lookup );
	
}
