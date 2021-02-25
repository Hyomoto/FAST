/// @func Pair
/// @param {any} a The value of a
/// @param {any} b The value of b
/// @desc A simple garbage-collected pair of values.
/// @example
//var _pair = new Pair( "Hello", "World!" )
//
//show_debug_message( _pair.a + _pair.b );
/// @output HelloWorld! is written to the output console.
/// @wiki Core-Index
function Pair( _a, _b ) constructor {
	/// @param {Pair} pair The Pair to compare to this one
	/// @desc This method can also be provided another Vec2 for purposes of comparison. This is a strict comparison of the internal values, testing a Pair against itself will return true, but does not test if the Vec2 structures are the same one.
	/// @alias equals pair
	/// @param {any} a The value to compare a to
	/// @param {any} b The value to compare b to
	/// @desc This method is used to compare two values against this pair to see if they match. This is a strict comparison, thus it will only return true if both a and b match the provided arguments.
	/// @dupe
	static equals	= function( _a ) {
		if ( is_struct_of( _a, Pair ) ) {
			return ( _a.a == a && _a.b == b );
			
		}
		return ( argument_count > 1 && a == _a && b == argument[ 1 ] );
		
	}
	/// @desc the a value
	a	= _a;
	/// @desc the b value
	b	= _b;
	
}
