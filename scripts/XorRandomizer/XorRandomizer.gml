/// @func XorRandomizer
function XorRandomizer() : __Randomizer__() constructor {
	static seed	= function( _seed ) {
		if ( _seed == undefined ) {
			__State	= date_current_datetime() | 0;
			
		} else {
			if ( is_numeric( _seed ) == false ) {}
			
			__State	= ( _seed * 42379876741 ) & 0xFFFFFFFFFFFF;
			
		}
		return self;
		
	}
	static next	= function() {
		__State ^= __State << 13;
		__State ^= __State >> 17;
		__State ^= __State << 5;
		
		return __State & 0xFFFFFFFFFFFF;
		
	}
	__State	= 1;
	
}
