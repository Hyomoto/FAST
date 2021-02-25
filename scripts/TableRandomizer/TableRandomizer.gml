/// @func TableRandomizer
/// @param {int}	seed	The starting seed for this randomizer.  If you are generating a table, this seed is used to generate the table instead.
/// @param {array}	table	The table of numbers to use.
/// @desc	Creates a randomizer that relies on a table of lookup values to produce random numbers. This
///		can be helpful if you wish to weight certain numbers, but has the drawback of requiring an array
///		the size of the table.  Each time a random number is drawn, the pointer in the table advances to
///		the next one and returns the value stored there.  You may provide your own table of numbers, or
///		have one generated.
/// @example
///global.rng	= new TableRandomizer( undefined, 256 );
/// @output
///A randomizer that contains a table of 256 values.
function TableRandomizer( _seed, _table ) : Randomizer() constructor {
    /// @desc Returns the next random integer from the generator.
    /// @returns integer
    static next    = function() {
		if ( table == undefined ) { return 0; }
		if ( ++state == array_length( table ) ) { state = 0; }
		
		return table[ state ];
		
    }
	static generate	= function( _seed, _size ) {
		table	= array_create( _size );
		
		var _i = 0; repeat( _size ) { table[ _i ] = _i; ++_i; }
		
		array_shuffle( table, _seed );
		
	}
	table	= undefined;
	
	if ( is_numeric( _table ) ) { generate( _seed, _table | 0 ); }
	else if ( is_array( _table ) ) {
		table	= _table;
		seed( _seed );
		
	}
    
}
