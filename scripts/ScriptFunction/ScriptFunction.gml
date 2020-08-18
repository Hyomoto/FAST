/// @func ScriptFunction
/// @param name
/// @param [args]
/// @param func
/// @param name
/// @param [args]
/// @param function
function ScriptFunction( _name, _args, _func ) constructor {
	static execute	= function( _engine ) {
		var _local	= {}
		
		var _i = 0; repeat( array_length( args ) ) {
			variable_struct_set( _local, args[ _i++ ], _engine.stack.pop() );
			
		}
		if ( isScript ) {
			func.local	= _local;
			
			_engine.execute( func );
			
			return;
			
		}
		var _func	= method( _local, func );
		
		_engine.stack.push( _func() );
		
	}
	static toString	= function() {
		var _string	= name + "(";
		
		var _i = 0; repeat( array_length( args ) ) {
			if ( _i > 0 ) { _string += "," }
			
			_string	+= " " + args[ _i ];
			
		}
		return _string + " )";
		
	}
	isScript= ( instanceof( _func ) == "ScriptFile" );
	name	= _name;
	args	= _args;
	func	= _func;
	
}
