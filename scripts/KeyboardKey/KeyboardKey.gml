/// @param {String,Constant.VirtualKey} _keycode
function KeyboardKey( _keycode ) constructor {
	static pressed	= function() {
		return keyboard_check_pressed( keycode );
		
	}
	static released	= function() {
		return keyboard_check_released( keycode );
		
	}
	static held	= function() {
		return keyboard_check( keycode );
		
	}
	keycode	= ( function( _keycode ) {
        if is_real(_keycode)
            return _keycode;
        if ( string_length( _keycode ) == 1 ) {
			if ( _keycode >= "a" && _keycode <= "z" ) || ( _keycode >= "A" && _keycode <= "Z" )
				return ord( string_upper( _keycode ));
			if ( _keycode >= "0" && _keycode <= "9" )
				return ord( _keycode );
			switch( _keycode ) {
				case "-" : return 189;
				case "=" : return 187;
				case "[" : return 219;
				case "]" : return 221;
				case ";" : return 186;
				case "'" : return 222;
				case "," : return 188;
				case "." : return 190;
				case "/" : return 191;
				case "_" : return 189;
				case "+" : return 187;
				case "{" : return 219;
				case "}" : return 221;
				case ":" : return 186;
				case "\"": return 222;
				case "<" : return 188;
				case ">" : return 190;
				case "?" : return 191;
				case "\\": return 220;
				case "|" : return 220;
				case "`" : return 192;
				case "~" : return 192;
				case "!" : return 49;
				case "@" : return 50;
				case "#" : return 51;
				case "$" : return 52;
				case "%" : return 53;
				case "^" : return 54;
				case "&" : return 55;
				case "*" : return 56;
				case "(" : return 57;
				case ")" : return 48;
				
			}
			
		}
		switch( string_lower( _keycode )) {
			case "pgup" : case "pageup" : return vk_pageup;
			case "pgdown" : case "pagedown" : return vk_pagedown;
			case "num" : case "numlock" : return 144;
			case "tab" : return vk_tab;
			case "caps" : case "capslock" : return 20;
			case "shift" : return vk_shift;
			case "left shift" : case "lshift" : return vk_lshift;
			case "right shift": case "rshift" : return vk_rshift;
			case "alt" : return vk_alt;
			case "left alt" : case "lalt" : return vk_lalt;
			case "right alt": case "ralt" : return vk_ralt;
			case "control" : return vk_control;
			case "left control" : case "lcontrol" : return vk_lcontrol;
			case "right control": case "rcontrol" : return vk_rcontrol;
			case "return": return vk_return;
			case "enter" : return vk_enter;
			case "insert": case "ins" : return vk_insert;
			case "delete": case "del" : return vk_delete;
			case "f1" : return vk_f1;
			case "f2" : return vk_f2;
			case "f3" : return vk_f3;
			case "f4" : return vk_f4;
			case "f5" : return vk_f5;
			case "f6" : return vk_f6;
			case "f7" : return vk_f7;
			case "f8" : return vk_f8;
			case "f9" : return vk_f9;
			case "f10": return vk_f10;
			case "f11": return vk_f11;
			case "f12": return vk_f12;
			case "num0" : case "n0" : return vk_numpad0;
			case "num1" : case "n1" : return vk_numpad1;
			case "num2" : case "n2" : return vk_numpad2;
			case "num3" : case "n3" : return vk_numpad3;
			case "num4" : case "n4" : return vk_numpad4;
			case "num5" : case "n5" : return vk_numpad5;
			case "num6" : case "n6" : return vk_numpad6;
			case "num7" : case "n7" : return vk_numpad7;
			case "num8" : case "n8" : return vk_numpad8;
			case "num9" : case "n9" : return vk_numpad9;
			case "num+" : case "n+" : return vk_add;
			case "num-" : case "n-" : return vk_subtract;
			case "num*" : case "n*" : return vk_multiply;
			case "num/" : case "n/" : return vk_divide;
			case "num." : case "n." : return 46;
			case "up"   : return vk_up;
			case "down" : return vk_down;
			case "left" : return vk_left;
			case "right": return vk_right;
			
		}
		throw $"\n\n\nBad code provided for KeyboardKey {_keycode}\n\n\n";
		
	})( _keycode );
	
}
