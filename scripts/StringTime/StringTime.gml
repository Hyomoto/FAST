/// @func StringTime
/// @param {int}	seconds		The number of seconds
/// @param {int}	decimals	How many decimals each time should contain
/// @param {string}	format		The display format, $H, $M and $S will be replaced with hours, minutes, and seconds
/// @desc Given a time, in seconds, will output it as formatted time string.
/// @example
//var _time = new StringTime( get_timer(), 0, "$H hours, $M minutes, and $seconds" );
//
//show_debug_message( _time );
/// @wiki Core-Index Strings
function StringTime( _value, _decimals, _format ) : String() constructor {
	/// @param {int}	seconds			The number of seconds to set the time to
	/// @desc	Will format the provided seconds into a formatted time string.
	static set	= function( _value ) {
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
		__String	= _string;
		
	}
	static toString	= function() {
		return __String;
		
	}
	__String	= "";
	/// @desc the format as provided by the format argument
	format		= _format;
	/// @desc the decimals as provided by the decimals argument
	decimals	= _decimals;
	
}
