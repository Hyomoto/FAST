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
		
		__Yield	= _result[ 0 ] == FAST_SCRIPT_YIELD;
		
		return _result[ 1 ];
		
	}
	static is_yielded	= function() {
		return __Yield;
		
	}
	__Yield		= true;
	__Script	= _script;
	__Lump		= _lump;
	
	__Type__.add( Script );
	__Type__.add( ScriptCoroutine );
	
}
