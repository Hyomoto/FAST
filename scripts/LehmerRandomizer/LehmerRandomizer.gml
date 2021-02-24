/// @func LehmerRandomizer
function LehmerRandomizer() : Randomizer() constructor {
    static seed    = function( _seed ) {
        state    = ( ( is_undefined( _seed ) ? 0x0 : round( _seed ) ) << 1 ) | 1;
        
		return self;
		
    }
    /// @desc Returns the next random integer from the generator.
    /// @returns integer
    static next    = function() {
        state = ( state * 279470273 ) % 0xfffffffb;
        
        return state;
        
    }
    seed( _seed );
    
}
