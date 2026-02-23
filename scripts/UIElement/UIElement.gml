function UIElement() constructor {
	static draw	= function( _x = 0, _y = 0 ) {}
	/// @param {Function,Array} _function
	static before	= function( _function ) {
		if ( is_array( _function ) == false )
			beforeDraw	= [ _function ];
		else
			beforeDraw	= _function;
		return self;
		
	}
	/// @param {Function,Array} _function
	static after	= function( _function ) {
		if ( is_array( _function ) == false )
			afterDraw	= [ _function ];
		else
			afterDraw	= _function;
		return self;
		
	}
	beforeDraw	= undefined;
	afterDraw	= undefined;
	
}
