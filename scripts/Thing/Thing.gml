function Thing() constructor {
	static clone	= function() {
		return variable_clone( self );
		
	}
	static type		= function() {
		return asset_get_index( instanceof( self ));
		
	}
	
}