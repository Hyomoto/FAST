/// @func script_evaluate
/// @param script
/// @param local
/// @param engine
function script_evaluate( _expression, _local, _engine ) {
	var _temp	= false;
	var _lang	= undefined;
	var _error;
	
	_expression.start();
	// variable assignment
	if ( _expression.operate ) {
		if ( _expression.assign ) {
			_engine.log( "script_execute", "Language operation mixed with value assigment. Aborted." );
			_engine.error	= 1;
			
			return -1;
			
		}
		_lang	= _expression.next().value;
		
	} else if ( _expression.assign ) {
		var _result;
		var _assign;
		
		if ( _expression.next().code != SCRIPT_VARIABLE ) {
			_engine.log( "script_execute", "Assignment must begin with a variable. Aborted." );
			_engine.error	= 1;
			
			return -1;
			
		}
		if ( _expression.last().value == "var" ) {
			_assign	= _expression.next().value;
			_temp	= true;
			
		} else {
			_assign	= _expression.last().value;
			
		}
		if ( _expression.next().code != SCRIPT_ASSIGNMENT ) {
			_engine.log( "script_execute", "Expected `=`, got \"", _expression.last().value, "\". Aborted." );
			_engine.error	= 1;
			
			return -1;
			
		}
		
	}
	_error	= script_get_value( _expression, _local, _engine );
	
	_result	= _engine.stack.pop();
	
	if ( _error == 0 ) { 
		while ( _expression.has_next() ) {
			switch ( _expression.next().value ) {
				case "&&" :	_error	= script_get_value( _expression, _local, _engine ); _result = _engine.stack.pop() && _result; break;
				case "||" :	_error	= script_get_value( _expression, _local, _engine ); _result = _engine.stack.pop() || _result; break;
				
				case ">" :	_error	= script_get_value( _expression, _local, _engine ); _result = _result > _engine.stack.pop(); break;
				case "<" :	_error	= script_get_value( _expression, _local, _engine ); _result = _result < _engine.stack.pop(); break;
				case ">=" :	_error	= script_get_value( _expression, _local, _engine ); _result = _result >= _engine.stack.pop(); break;
				case "<=" :	_error	= script_get_value( _expression, _local, _engine ); _result = _result <= _engine.stack.pop(); break;
				
				case "==" :	_error	= script_get_value( _expression, _local, _engine ); _result = _result == _engine.stack.pop(); break;
				
				case "&" :	_error	= script_get_value( _expression, _local, _engine ); _result = _result & _engine.stack.pop(); break;
				case "|" :	_error	= script_get_value( _expression, _local, _engine ); _result = _result | _engine.stack.pop(); break;
				
				case "+" :	_error	= script_get_value( _expression, _local, _engine ); _result = _result + _engine.stack.pop(); break;
				case "-" :	_error	= script_get_value( _expression, _local, _engine ); _result = _result - _engine.stack.pop(); break;
				case "*" :	_error	= script_get_value( _expression, _local, _engine ); _result = _result * _engine.stack.pop(); break;
				case "/" :	_error	= script_get_value( _expression, _local, _engine ); _result = _result / _engine.stack.pop(); break;
				default :
					_engine.log( "script_execute", "Malformed assignment: expected operator, got \"", _expression.last().value, "\". Aborted." );
					_engine.error	= 1;
					
					return -1;
					
			}
			if ( _error != 0 ) {
				return _error;
				
			}
			
		}
		
	}
	_engine.stack.push( _result );
	
	if ( _expression.operate ) {
		if ( _expression.first().goto != -1 ) {
			_engine.stack.push( _expression.first().goto );
			
		}
		return _expression.first().escape;
		
	} else if ( _expression.assign ) {
		
		if ( _temp ) {
			variable_struct_set( _local, _assign, _engine.stack.pop() );
			
		} else {
			_engine.set_value( _assign, _engine.stack.pop() );
			
		}
		
	}
	return 0;
	
}
