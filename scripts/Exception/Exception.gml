function Exception( _message ) constructor {
	static toString	= function() {
		return "\n\n\n" + string_repeat( "~", 40 ) + "\n" + message + "\n" + string_repeat( "~", 40 ) + "\n\n\n";
		
	}
	message		= _message;
	
}
