function Gamepad( _id = 0 ) constructor {
	static isConnected = function() {
        return gamepad_is_connected( pad );
        
    }
    static update = function() {}
    
	pad	= _id;
	
}
