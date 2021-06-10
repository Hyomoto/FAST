/// @func __Error__
/// @desc	__Error__ is an inheritable type for building Errors.  It provides a convenient point of
///		entry and formatting for GML errors and is used by all errors thrown by FAST.
function __Error__() : __Struct__() constructor {
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
	
	__Type__.add( __Error__ );
	__Type__.add( __Self__ );
	
}
