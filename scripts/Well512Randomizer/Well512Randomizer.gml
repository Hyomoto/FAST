/// @func Well512Randomizer
/// @desc	A GML implementation of the Well512 randomizer as described by Chris Lomont in
///		http://lomont.org/papers/2008/Lomont_PRNG_2008.pdf.  This is the same type used
///		internally by GMS to produce random numbers.
/// @wiki Numbers-Index Randomizers
function Well512Randomizer() : __Randomizer__() constructor {
	static seed	= function( _seed ) {
		if ( _seed == undefined ) { _seed = date_current_datetime(); }
		
		var _i = 0; repeat( 16 ) {
			_seed ^= _seed << 13;
			_seed ^= _seed >> 17;
			_seed ^= _seed << 5;
			
			__State[ _i++ ]	= abs( _seed & 0xFFFFFFFFFFFF );
			
		}
		return self;
		
	}
	static next	= function() {
		var _a, _b, _c, _d;
		_a = __State[ __Index ];
		_c = __State[(__Index + 13 ) & 0xF ];
		_b = _a ^ _c ^ ( _a << 16 ) ^ ( _c << 15 );
		_c = __State[(__Index + 9 ) & 0xF ];
		_c ^= ( _c >> 11 );
		_a = __State[ __Index ] = _b^_c;
		_d = _a ^ (( _a << 5 ) & 0xDA442D24);
		__Index = (__Index + 15) & 0xF;
		_a = __State[ __Index ];
		__State[ __Index ] = _a ^ _b ^ _d ^ ( _a << 2 ) ^ ( _b << 18 ) ^ ( _c << 28 );
		return __State[ __Index ] & 0xFFFFFFFF;
		
	}
	__State	= array_create( 16, 0 );
	__Index	= 0;
	
}
