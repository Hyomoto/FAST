/// @func Pair
/// @param a
/// @param b
function Pair( _a, _b ) constructor {
	static equals	= function( _a ) {
		if ( is_struct( _a ) && instanceof( _a ) == "Pair" ) {
			return ( _a.a == a && _a.b == b );
		
		}
		return ( argument_count > 1 && a == _a && b == argument[ 1 ] );
		
	}
	a	= _a;
	b	= _b;
	
}
