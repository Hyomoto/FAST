/// @func String
/// @desc	A parsable version of the string.
/// @wiki Core-Index Data Structures
function String() : __Struct__() constructor {
	/// @param {mixed}	values...	Values to push
	/// @desc	Adds the values in order to the top of the string.
	/// @returns self
	static push	= function() {
		var _i = 0; repeat( argument_count ) {
			if ( __String != "" )
				__String += "\n";
			__String += argument[ _i++ ];
			
		}
		return self;
		
	}
	/// @desc	Pops the value off the top of the string and returns it.  If the string is empty,
	///		EOS is returned instead.
	/// @returns mixed or EOS
	static pop	= function() {
		if ( __String == "" ) { return EOS; }
		
		var _i	= string_pos( "\n", __String );
		var _c	= string_copy( __String, 1, _i - 1 );
		
		__String	= string_delete( __String, 1, _i );
		
		return _c;
		
	}
	/// @desc	Peeks at the top value of the string and returns it.  If the string is empty,
	///		EOS is returned instead.
	/// @returns mixed or EOS
	static peek	= function() {
		if ( __String == "" ) { return EOS; }
		
		var _i	= string_pos( "\n", __String );
		
		return string_copy( __String, 1, _i - 1 );
		
	}
	/// @desc	Returns true if the string is empty.
	/// @returns bool
	static is_empty	= function() {
		return __String == "";
		
	}
	/// @desc	Returns the length of the string.
	/// @returns int
	static size	= function() {
		return string_length( __String );
		
	}
	/// @desc	Clears the string.
	/// @returns int
	static clear	= function() {
		__String	= "";
		
	}
	/// @desc	Returns the string
	static toString	= function() {
		return __String;
		
	}
	/// @var {strict}	A value that is returned when the string is empty
	static EOS	= {}
	/// @var {struct}	The internal string
	__String	= undefined;
	
	__Type__.add( __Stream__ );
	__Type__.add( String );
	
}
