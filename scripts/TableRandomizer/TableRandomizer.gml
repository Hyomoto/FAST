/// @func TableRandomizer
/// @param {int}	seed	The starting seed for this randomizer.  If you are generating a table, this seed is used to generate the table instead.
/// @param {array}	table	The table of numbers to use.
/// @desc	Uses a pre-defined table of lookup values to return random numbers. This can be helpful if
///		you wish to weight certain numbers, but has the drawback of requiring an array the size of the
///		table.  Each time a random number is drawn, the pointer in the table advances to the next one
///		and returns the value stored there.  You may provide your own table of numbers, or have one
///		generated.
/// @example
///global.rng	= new TableRandomizer( undefined, 256 );
/// @output A randomizer that contains a table of 256 values.
function TableRandomizer() : __Randomizer__() constructor {
    /// @desc	Returns the next number in the table.  If the last number has been read, the
	///		read position will return to the start of the table.
    /// @returns int
    static next    = function() {
		if ( __Table == undefined ) { return 0; }
		
		__State	= ++__State % array_length( __Table );
		
		return __Table[ state ];
		
    }
	/// @param {int}		size	The size of the table
	/// @param {Randomizer}	*rand	optional: If specified, will be used instead of GMS' functions
	/// @desc	Populates a new table of size elements using seed.  The table will contain each
	///		number 0 to size - 1 inclusive.  If size is not a number or is less than 1, or rand is
	///		not a {#__Randomizer__}, InvalidArgumentType will be thrown.
	/// @throws InvalidArgumentType
	/// @returns self
	static generate	= function( _size, _rand ) {
		if ( is_numeric( _size ) == false ) { throw InvalidArgumentType( "generate", 0, _size, "int" ); }
		
		__Table	= array_create( _size );
		
		var _i = 0; repeat( _size ) { __Table[ _i ] = _i++; }
		
		array_shuffle( __Table, _rand );
		
		return self;
		
	}
	/// @param {array}	array	The array of values
	/// @desc	Sets the table of values used to return numbers. If an array is not provided,
	///		InvalidArgumentType will be thrown.
	/// @throws InvalidArgumentType
	/// @returns self
	static from_array	= function( _arr ) {
		if ( is_array( __Table ) == false ) { throw new InvalidArgumentType( "from_array", 0, _arr, "array" ); }
		
		__Table	= _arr;
		
		return self;
		
	}
	/// @var {array}	The table used to look up numbers
	__Table	= undefined;
	
}
