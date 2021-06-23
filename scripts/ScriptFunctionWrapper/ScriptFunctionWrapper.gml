/// @func ScriptFunctionWrapper
/// @param {int}	script_function	A GMS script function
/// @desc	When FAST_SCRIPT_PROTECT_FUNCTIONS is true, fscript will reject function calls if they are
///		not wrapper in ScriptFunctionWrapper.  This struct marks them as safe-for-execution.  This is to prevent
///		malicious code injection via external scripts and modding and allows the script engine to be
///		properly sandboxed.
/// @example
//var _scope = {
//  print: new SafeScript( show_debug_message )
//}
//script.execute( _scope );
/// @output `print` would be usable as a function alias for show_debug_message in the executed script
function ScriptFunctionWrapper( _value ) : __Struct__() constructor {
	static toString	= function() { return "script function"; }
	__Value	= _value;
	
	__Type__.add( ScriptFunctionWrapper );
	
}
