/// @func __Error__
/// @desc	__Error__ is an inheritable type for building Errors.  It provides a convenient point of
///		entry and formatting for GML errors.
function __Error__() constructor {
	static conc	= function() { var _s = ""; var _i = 0; repeat( argument_count ) { _s += string( argument[ _i++ ] ); }; return _s; }
	static toString	= function() {
		var _msg	= instanceof( self ) + " :: " + message;
		
		if ( string_length( _msg ) > __Width__ ) {
			var _l = 0, _n = 0; while ( true ) {
				_n	= string_pos_ext( " ", _msg, _l );
				
				if ( _n == 0 ) { break; }
				if ( _n > __Width__ ) {
					_msg	= string_insert( "\n", _msg, _l );
					
					if ( string_length( _msg ) - _n <= __Width__ )
						break;
						
				}
				_l	= _n;
				
			}
			
		}
		return "\n\n\n" + _msg + "\n\n";
		
	}
	static __Width__	= 92;
	__Type__	= asset_get_index( instanceof( self ) );
	
}
function error_type( _ex ) {
	if ( is_struct( _ex ) == false ) { return undefined; }
	
	return _ex[$ "__Type__" ];
	
}
function IndexOutOfBounds( _call, _index, _bounds ) : __Error__() constructor {
	message	= conc( "The provided index(", _index, ") to function \"", _call, "\" was out of range(size was ", _bounds, ")." )
}
function ValueNotFound( _call, _value, _index ) : __Error__() constructor {
	message	= conc( "The value(", _value, ") provided to function \"", _call, "\" didn't exist in the structure." );
	index	= _index;
}
function InvalidArgumentType( _call, _arg, _value, _expected ) : __Error__() constructor {
	message	= conc( "The value(", _value, ") provided as argument ", _arg, " to function \"", _call, "\" was of the wrong type(got ", typeof( _value ), ", expected ", _expected, ")" );
}
function UnexpectedTypeMismatch( _call, _value, _expected ) : __Error__() constructor {
	message	= conc( "The function ", _call, " expected type of ", _expected, " but recieved ", typeof( _value ), "." );
}
function BadJSONFormat( _call ) : __Error__() constructor {
	message	= conc( "The function ", _call, " expected a JSON string, but it could not be converted." );
}
