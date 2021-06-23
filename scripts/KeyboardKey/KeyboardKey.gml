/// @func KeyboardKey
/// @param {int/string}	constant	Either a `vk_` constant or a string of the key to be pressed.
/// @desc	Converts keyboard inputs into a format used by (#InputDevice). KeyboardKey will also
//		interpret the -=[]\;',./ characters if provided.
/// @wiki Input-Handling-Index Keyboard
function KeyboardKey( _constant ) : __InputSource__() constructor {
	static down	= function() {
		return keyboard_check( __Constant );
		
	}
	if ( is_string( _constant ) ) {
		switch ( _constant ) {
			case ":" : case ";" : _constant	= 186; break;
			case "\"": case "'" : _constant = 222; break;
			case "{" : case "[" : _constant = 219; break;
			case "}" : case "]" : _constant = 221; break;
			case "_" : case "-" : _constant = 189; break;
			case "+" : case "=" : _constant = 187; break;
			case "<" : case "," : _constant = 188; break;
			case ">" : case "." : _constant = 190; break;
			case "?" : case "/" : _constant = 191; break;
			case "~" : case "`" : _constant = 192; break;
			case "|" : case "\\": _constant = 220; break;
			default :
				_constant	= ord( string_upper( _constant ) );
				
		}
		
	}
	/// @desc The mouse button to check for inputs.
	__Constant	= _constant;
	
}
