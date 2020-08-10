/// @func StringTime
/// @param value
/// @param decimals
/// @param format
function StringTime( _value, _decimals, _format ) : __String() constructor {
	static formatter	= function( _value ) {
		var _string		= format;
		var _hours		= string_pos( "$H", format ) > 0;
		var _minutes	= string_pos( "$M", format ) > 0;
		var _seconds	= string_pos( "$S", format ) > 0;
		
		if ( _hours ) {
			var _hour	= string_format( ( _minutes || _seconds ? _value div 3600 : _value / 3600 ), 0, decimals );
			_value		= _value mod 3600;
			_string	= string_replace( _string, "$H", _hour );
			
		}
		if ( _minutes ) {
			var _minute	= string_format( ( _seconds ? _value div 60 : _value / 60 ), 0, decimals );
			_value		= _value mod 60;
			_string	= string_replace( _string, "$M", _minute );
			
		}
		if ( _seconds ) {
			var _second	= string_format( _value, 0, decimals );
			_string	= string_replace( _string, "$S", _second );
			
		}
		return _string;
		
	}
	format		= _format;
	decimals	= _decimals;
	
	set( _value );
	
}
