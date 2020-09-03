/// @func Pair
/// @param a
/// @param b
function Pair( _a, _b ) constructor {
	static equals	= function( _a ) {
		if ( is_struct( _a ) && _a.is( Pair ) ) {
			return ( _a.a == a && _a.b == b );
			
		}
		return ( argument_count > 1 && a == _a && b == argument[ 1 ] );
		
	}
	static is		= function( _data_type ) {
		return _data_type == Pair;
		
	}
	a	= _a;
	b	= _b;
	
}
