function ScriptSafe( _value ) : __Struct__() constructor {
	static toString	= function() { return "GMS function"; }
	__Value	= _value;
	
	__Type__.add( ScriptSafe );
	
}
enum FAST_SCRIPT_TYPE {
	VALUE,
	FUNCTION,
	
}
