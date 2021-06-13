/// @func __Struct__
/// @desc	The struct base implements a type checking system and __Self__ access for inherited
///		constructors.  The __Type__ feature allows constructors to be looked up by their implement
///		chains rather than plain text function name.  Using `struct_type( self, __Struct__ )` will
///		return false because the implementation of __Type__ is sufficient evidence.  The __Self__
///		variable will return the constructor id that the final struct was created from.
/// @wiki Core-Index Abstract
function __Struct__() constructor {
	/// @var {struct}	Holds the type map so heritage can be inspected
	/// @output {}
	__Type__	= { add: function( _type ) { variable_struct_set( self, string( _type ), 1 ); }}
	/// @var {int}		The index of the final constructor in the inheritance chain.
	__Self__	= asset_get_index( instanceof( self ) );
	
}
