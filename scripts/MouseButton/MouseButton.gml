/// @param {String,Constant.MouseButton} _code
function MouseButton( _code ) constructor {
	static pressed	= function() {
		return mouse_check_button_pressed( keycode );
		
	}
	static released	= function() {
		return mouse_check_button_released( keycode );
		
	}
	static held	= function() {
		return mouse_check_button( keycode );
		
	}
	keycode	= ( function( _code ) {
        switch( _code ) {
            case mb_left  : return mb_left;
            case mb_right : return mb_right;
            case mb_middle: return mb_middle;
            case mb_side1 : return mb_side1;
            case mb_side2 : return mb_side2;
			case "left"   : return mb_left;
			case "right"  : return mb_right;
			case "middle" : return mb_middle;
			case "back"   :	
			case "side1"  : return mb_side1;
			case "forward": 
			case "side2"  : return mb_side2;
			
		}
		throw $"\n\n\nBad code provided for MouseButton {_code}\n\n\n";
    })( _code );
	
}
