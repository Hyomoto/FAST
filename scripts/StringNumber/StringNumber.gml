/// @func StringNumber
/// @param value
/// @param truncate
/// @param decimals
/// @param base
function StringNumber( _value, _truncate, _decimals, _base ) : String( _value ) constructor {
	static suffix	= function( _exponent ) {
		static suffixes	= [ "", " K", " M", " B", " AA", " BB", " CC", " DD", " EE", " FF", " GG", " HH", " II", " JJ", " KK", " LL", " MM", " NN", " OO", " PP", " QQ", " RR", " SS", " TT", " UU", " VV" ];
		
		_exponent	= _exponent div 3;
		
		return ( _exponent < 0 || _exponent >= array_length( suffixes ) ? "" : suffixes[ _exponent ] );
		
	}
	static formatter	= function( _value ) {
		var _exponent	= 0;
		var _base		= base;
		var _string, _place
		
		if ( _value >= infinity ) { return "INF" }
		while ( _base != undefined && _value >= _base ) {
			_exponent	+= 3;
			_base		:= power( 10, _exponent + 3 );
			
		}
		if ( _exponent > 0 ) {
			_string	= string_format( _value / power( 10, _exponent ), 0, decimals[ 1 ] );
			_string	= string_copy( _string, 1, truncate );
			
		} else {
			_string	= string_format( _value, 0, decimals[ 0 ] );
			_place	= string_length( _string ) - 3;
			
			if ( string_pos( ".", _string ) > 0 ) { _place	-= 3; }
			
			while ( _place >= 1 ) {
				_string	= string_copy( _string, 1, _place ) + "," + string_delete( _string, 1, _place );
				_place	-= 3;
				
			}
			
		}
		return _string + suffix( _exponent );
		
	}
	decimals	= ( is_array( _decimals ) ? _decimals : [ _decimals, _decimals ] );
	truncate	= ( _truncate == undefined ? 0 : _truncate );
	base		= _base;
	
	set( _value );
	
}
