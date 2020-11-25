/// @func InputCombo
/// @param {InputGeneric}	InputGeneric...	A list of inputs to use in combination.
/// @desc	Returns true when 
/// @wiki Input-Handling-Index 
function InputCombo() : InputGeneric() constructor {
	/// @desc Returns `true` if the combination of these inputs are being "pressed".
	static down	= function() {
		var _i = 0; repeat( size ) {
			if ( inputs[ _i++ ].down() == false ) { return false; }
			
		}
		return true;
		
	}
	/// @desc An array of inputs to check
	inputs	= array_create( argument_count );
	
	try {
		var _i = 0; repeat( argument_count ) {
			if ( is_struct_of( argument[ _i ], InputGeneric ) == false ) { throw( instanceof( argument[ _i ] ) + " must be a InputGeneric!" ); }
			
			inputs[ _i ]	= argument[ _i ];
			
			++_i;
			
		}
		
	} catch ( _ex ) {
		InputManager().log( "InputCombo error, " + ( is_struct( _ex ) ? variable_struct_get( _ex, "message" ) : _ex ) );
		
		inputs	= [];
		size	= 0;
		
		return;
		
	}
	/// @desc The number of inputs in this combination
	size	= array_length( inputs );
	
}
