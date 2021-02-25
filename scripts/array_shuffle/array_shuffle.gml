/// @func array_shuffle
/// @param {array}	array
/// @param {int}	*seed
/// @desc	An implementation of the Fisher-Yates shuffle. Performs an in-place, single-pass
///		randomization of the provided array.  Seed can be provided, if desired, to set the
///		GMS random seed before starting.
function array_shuffle( _array, _seed ) {
	if ( is_numeric( _seed ) ) { random_set_seed( _seed ); }
	
	var _size	= array_length( _array );
	
	var _g, _h, _i = 0; repeat( _size - 2 ) {
		var _g	= irandom_range( _i, _size - 2 );
		
		var _h	= table[ _i ];
		
		table[ _i ]	= table[ _g ];
		table[ _g ]	= _h;
		
		++_i;
		
	}
	
}
