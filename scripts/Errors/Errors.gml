/// @func IndexOutOfBounds
/// @desc	Thrown when a call is made to index a data structure that is out of bounds
function IndexOutOfBounds( _call, _index, _bounds ) : __Error__() constructor {
	message	= conc( "The provided index(", _index, ") to function \"", _call, "\" was out of range(size was ", _bounds, ")." )
}
/// @func ValueNotFound
/// @desc	Returned when a search is made for a value that doesn't exist in a data structure.
function ValueNotFound( _call, _value, _index ) : __Error__() constructor {
	message	= conc( "The value(", _value, ") provided to function \"", _call, "\" didn't exist in the structure." );
	index	= _index;
}
/// @func InvalidArgumentType
/// @desc	Thrown when an argument is provided of the wrong type.
function InvalidArgumentType( _call, _arg, _value, _expected ) : __Error__() constructor {
	message	= conc( "The value(", _value, ") provided as argument ", _arg, " to function \"", _call, "\" was of the wrong type(got ", typeof( _value ), ", expected ", _expected, ")" );
}
/// @func IndexOutOfBounds
/// @desc	Thrown when a value is returned legally, but is not of the type expected.
function UnexpectedTypeMismatch( _call, _value, _expected ) : __Error__() constructor {
	message	= conc( "The function ", _call, " expected type of ", _expected, " but recieved ", typeof( _value ), "." );
}
/// @func BadJSONFormat
/// @desc	Thrown when a JSON string is provided that can not be properly converted.
function BadJSONFormat( _call ) : __Error__() constructor {
	message	= conc( "The function ", _call, " expected a JSON string, but it could not be converted." );
}
/// @func IncompatibleFASTVersion
/// @desc	Thrown when a check for FAST version fails
function IncompatibleFASTVersion() : __Error__() constructor {
	message	= conc( "The installed version of FAST is out-of-date." );
	
}