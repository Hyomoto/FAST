/// @func ScriptCoroutine
/// @param {Script}	script	A Script
/// @param {struct}	data	A structure containing script state
/// @desc	ScriptCoroutine is used by {#evaluate_expression} and {#ScriptEngine} for wrapping up {#Script}s
///		that yield during execution.  They are typically cleaned up once a function has finished
///		yielding.  This constructor has no error checking to keep it as quick as possible, and
///		should not be necessary outside of it's provided contexts.
function ScriptCoroutine( _script, _data ) : __Struct__() constructor {
	static execute	= function( _global ) {
		__Data	= __Script.execute( _global, __Data );
		
		var _result	= __Data.result;
		
		return _result;
		
	}
	static is_yielded	= function() {
		return __Data.state == FAST_SCRIPT_YIELD;
		
	}
	__Script	= _script;
	__Data		= _data;
	
	__Type__.add( Script );
	__Type__.add( ScriptCoroutine );
	
}
