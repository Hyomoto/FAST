/// @func __Stream__
/// @param	{__Stream__}	type	A struct that can utilize the stream class
/// @desc	The stream type incorporates both __InputStream__ and __OutputStream__ to allow
///		reading and writing to the same source, while maintaining compatibility with functions
///		that require a stream.  However, stream does _not_ have the __Stream__ type!  This type
///		is used to indicate data types that can utilize __Stream__.
/// @wiki Core-Index Abstract
function __Stream__( _type ) : __Struct__() constructor {
	/// @desc	Reads the next chunk of data from the stream
	static read		= function() {
		if ( __Id == undefined )
			throw new IllegalStreamOperation( "read", "the stream target is not defined." );
		
		__Buffer	= __Content.pop()
		return __Buffer;
		
	}					
	/// @desc	Writes a chunk of data to the stream
	static write	= function() {
		if ( __Id == undefined )
			throw new IllegalStreamOperation( "write", "the stream target is not defined." );
		
		var _i = 0; repeat( argument_count ) {
			__Buffer	= __Content.push( argument[ _i++ ]);
			
		}
		return self;
		
	}
	/// @desc	Opens the stream.  This should facilitate re-opening a closed source
	///		if no arguments are provided.
	/// @throws IllegalStreamOperation
	/// @returns self
	static open		= function(s) {
		if ( __Id == undefined )
			throw new IllegalStreamOperation( "open", "the stream target is not defined." );
		
		__Type__.add( __InputStream__ );
		__Type__.add( __OutputStream__ );
		
		return self;
		
	}
	/// @desc	Closes the stream
	/// @throws IllegalStreamOperation
	/// @returns self
	static close	= function() {
		if ( __Id == undefined )
			throw new IllegalStreamOperation( "close", "the stream target is not defined." );
		
		variable_struct_remove( __Type__, string( __InputStream__ ));
		variable_struct_remove( __Type__, string( __OutputStream__ ));
		
		return self;
		
	}
	/// @desc	Returns true if the stream has nothing left to read
	static finished	= function() {
		return __Content.is_empty();
		
	}
	/// @desc	Returns the last value read/written to this stream
	static buffer	= function() { return __Buffer; }
	/// @desc	Returns true if the stream is currently open and available for reading.
	/// @returns bool
	static is_open	= function() { return __Id != undefined; }
	/// @var {int}		The stream source that has been opened for reading
	__Id		= _type	== undefined ? undefined : _type;
	
	if ( __Id != undefined && struct_type( __Id, __Stream__ ) == false )
		throw new InvalidArgumentType( "__init__", 0, __Id, "__Stream__" );
	
	/// @var {string}	A name that can be used to identify the stream source
	__Source	= _type == undefined ? "<undef>" : instanceof( _type );
	/// @var {string}	The last thing read from\written to the stream
	__Buffer	= undefined;
	
}
