/// @func __Struct__
/// @desc	A generic implementable struct that provides a framework for type checking.
function __Struct__() constructor {
	__Type__	= { add: function( _type ) { variable_struct_set( self, string( _type ), 1 ); }}
	__Self__	= asset_get_index( instanceof( self ) );
	
}
