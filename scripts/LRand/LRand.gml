/// @func LRand
/// @param {int}    seed    The starting seed for this randomizer.
function LRand( _seed ) : Randomizer() constructor {
    seed    = function( _seed ) {
        state    = ( ( is_undefined( _seed ) ? 0x0 : round( _seed ) ) << 1 ) | 1;
        
    }
    /// @desc Returns the next random integer from the generator.
    /// @returns integer
    rand    = function() {
        state = ( state * 279470273 ) % 0xfffffffb;
        
        return state;
        
    }
    seed( _seed );
    
}
