/// @func string_to_real
/// @param {string}	value		the string to be converted
/// @desc	converts the provided string into a int or real if possible, also accepts hex format
function string_to_real( _value ) {
	var _string	= string_lower( _value );
	var _digits = string_length( _string );
	var _result = 0;
	var _bit;
	
	if ( string_copy( _string, 1, 2 ) == "0x" ) {
		for ( var _i = _digits; _i > 2; _i-- ) {
			_bit	= ( _digits - _i ) * 4;
			
			switch ( string_byte_at( _string, _i ) - 0x30 ) {
				case 0x0 : _result |= ( 0x0 << _bit ); break;
				case 0x1 : _result |= ( 0x1 << _bit ); break;
				case 0x2 : _result |= ( 0x2 << _bit ); break;
				case 0x3 : _result |= ( 0x3 << _bit ); break;
				case 0x4 : _result |= ( 0x4 << _bit ); break;
				case 0x5 : _result |= ( 0x5 << _bit ); break;
				case 0x6 : _result |= ( 0x6 << _bit ); break;
				case 0x7 : _result |= ( 0x7 << _bit ); break;
				case 0x8 : _result |= ( 0x8 << _bit ); break;
				case 0x9 : _result |= ( 0x9 << _bit ); break;
				case 0x31 : _result |= ( 0xA << _bit ); break;
				case 0x32 : _result |= ( 0xB << _bit ); break;
				case 0x33 : _result |= ( 0xC << _bit ); break;
				case 0x34 : _result |= ( 0xD << _bit ); break;
				case 0x35 : _result |= ( 0xE << _bit ); break;
				case 0x36 : _result |= ( 0xF << _bit ); break;
				
			}
			
		}
		return _result;
		
	}
	try {
		return real( _value );
		
	} catch ( _ ) {
		return 0;
		
	}
	
}
