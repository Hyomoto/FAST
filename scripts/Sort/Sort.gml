 /// @func Sort
 /// @desc	Creates a new Sort which can be used by sorting functions. Normal use would be to sort
 ///	an array containing structs or instances and sorting them by key.  However, this behavior
 ///	can be overriden by setting __Seek to a function that returns the variable you wish to use
 ///	for comparison.
function Sort() : __Struct__() constructor {
	static func	= function() {
		return method( self, compare );
		
	}
	static compare	= function( _a, _b ) {
		__Sort.index(0);
		
		repeat( __Sort.size() ) {
			var _key	= __Sort.next();
			var _left	= __Seek( _a, _key );
			var _right	= __Seek( _b, _key );
			
			if ( _left == _right )
				continue;
			if ( _left > _right )
				return __Dir;
			return -__Dir;
			
		}
		return 0;
		
	}
	static by	= function( _key ) {
		__Sort.clear();
		__Sort.push( _key );
		
		return self;
		
	}
	static thenBy	= function( _key ) {
		__Sort.push( _key );
		
		return self;
		
	}
	static ascend	= function() {
		__Dir	= 1;
		
		return self;
		
	}
	static descend	= function() {
		__Dir	= -1;
		
		return self;
		
	}
	__Seek	= variable_instance_get;
	__Sort	= new LinkedList();
	__Dir	= 1;
	
	__Type__.add( Sort );
	
}
