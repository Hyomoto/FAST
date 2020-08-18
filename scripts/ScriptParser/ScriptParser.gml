/// @func ScriptParser
/// @param string
function ScriptParser( _string ) : Parser ( _string ) constructor {
	static next		= function() {
		var _op		= undefined;
		var _cp		= undefined;
		var _close	= 0;
		var _safe	= false;
		var _start	= last + 1;
		var _ws		= true;
		var _char, _last = length + 1;
		
		var _i = last; repeat( length - last ) {
			_char	= string_char_at( value, ++_i );
			
			if ( _safe && _char != "\"" ) { continue; }
			
			switch ( _char ) {
				case "\"" :
					if ( _op != undefined ) { continue; }
					
					_safe ^= true; _ws = false;
					
					continue;
					
				case "+" : case "-" : case "*" : case "/" : case "=" : case "<" : case ">" :
					if ( _op != undefined ) { continue; }
					
					if ( _ws && string_char_at( value, _i + 1 ) == "=" ) {
						++_i;
						
					} else if ( !_ws && _char == "-" && string_char_at( value, _i + 1 ) == ">" ) {
						_i	+= 2;
						
					}
					_last	= ( _ws ? _i + 1 : _i-- );
					// resolve
					break;
				
				case "(" : case "{" : case "[" :
					if ( _op == undefined ) {
						_op		= _char
						_cp		= string_char_at( ")}]", string_pos( _char, "({[" ) );
						
					}
					if ( _op == _char ) {
						++_close;
						
					}
					_ws	= false;
					
					continue;
					
				case ")" : case "}" : case "]" :
					// if op matches char, and close is 0, resolve
					if ( _cp == _char ) {
						if ( --_close == 0 ) {
							_last	= _i + 1;
							
							break;
							
						}
						
					}
					continue;
					
				case " " : case "\t" :
					if ( _op != undefined ) { continue; }
					
					if ( _ws ) { ++_start; continue; }
					_last	= _i;
					// resolve
					break;
					
				default : _ws = false; continue;
				
			}
			break;
			
		}
		last	= _i;
		
		return string_copy( value, _start, _last - _start )
		
	}
	
}
