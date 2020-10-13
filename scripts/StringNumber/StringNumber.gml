#macro STRING_NUMBER_DEFAULT_INFINITY	"INF"

/// @func StringNumber
/// @param value
/// @param format
/// @desc	A wrapper for Numbers-as-strings.  Provides custom formatting options such as
//		comma insertion and suffixes.
function StringNumber( _string ) : String() constructor {
	static formatter	= function( _string ) {
		var _decimal	= string_pos( ".", _string );
		var _dround		= string_count( "#", string_delete( _string, 1, _decimal ) );
		// *#.##, *,###.#####, 
		
		
		
	}
	//decimals	= ( is_array( _decimals ) ? _decimals : [ _decimals, _decimals ] );
	//truncate	= ( _truncate == undefined ? 0 : _truncate );
	//base		= _base;
	format		= ( argument_count > 1 == undefined ?"*,###.##" : argument[ 1 ] );
	inf			= STRING_NUMBER_DEFAULT_INFINITY;
	
	set( _string );
	
	//static suffix	= function( _exponent ) {
	//	static suffixes	= [ "", " K", " M", " B", " AA", " BB", " CC", " DD", " EE", " FF", " GG", " HH", " II", " JJ", " KK", " LL", " MM", " NN", " OO", " PP", " QQ", " RR", " SS", " TT", " UU", " VV" ];
		
	//	_exponent	= _exponent div 3;
		
	//	return ( _exponent < 0 || _exponent >= array_length( suffixes ) ? "" : suffixes[ _exponent ] );
		
	//}
	//static formatter	= function( _value ) {
	//	var _exponent	= 0;
	//	var _base		= base;
	//	var _string, _place
		
	//	if ( _value >= infinity ) { return inf }
	//	while ( _base != undefined && _value >= _base ) {
	//		_exponent	+= 3;
	//		_base		:= power( 10, _exponent + 3 );
			
	//	}
	//	if ( _exponent > 0 ) {
	//		_string	= string_format( _value / power( 10, _exponent ), 0, decimals[ 1 ] );
	//		_string	= string_copy( _string, 1, truncate );
			
	//	} else {
	//		_string	= string_format( _value, 0, decimals[ 0 ] );
	//		_place	= string_length( _string ) - 3;
			
	//		if ( string_pos( ".", _string ) > 0 ) { _place	-= 3; }
			
	//		while ( _place >= 1 ) {
	//			_string	= string_copy( _string, 1, _place ) + "," + string_delete( _string, 1, _place );
	//			_place	-= 3;
				
	//		}
			
	//	}
	//	return _string + suffix( _exponent );
		
	//}
	
}
