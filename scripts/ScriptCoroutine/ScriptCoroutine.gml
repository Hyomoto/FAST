/// @func ScriptCoroutine
/// @param {Script}	script	A Script
/// @param {struct}	data	A structure containing script state
/// @desc	ScriptCoroutine is used by {#evaluate_expression} and {#ScriptEngine} for wrapping up {#Script}s
///		that yield during execution.  They are typically cleaned up once a function has finished
///		yielding.  This constructor has no error checking to keep it as quick as possible, and
///		should not be necessary outside of it's provided contexts.
function ScriptCoroutine( _script, _lump ) : __Struct__() constructor {
	static execute	= function() {
		var _result	= __Script.from_lump().execute( __Lump );
		
		__Yield	= __Lump.state == FAST_SCRIPT_YIELD;
		
		return _result;
		
	}
	static is_yielded	= function() {
		return __Yield;
		
	}
	static toString	= function() {
		return __Script.__Source;
		
	}
	__Yield		= true;
	__Script	= _script;
	__Lump		= _lump;
	
	__Type__.add( Script );
	__Type__.add( ScriptCoroutine );
	
}
