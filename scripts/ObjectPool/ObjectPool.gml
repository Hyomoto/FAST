/// @func ObjectPool
/// @param {method}	new		A method that returns a new object for this pool.
/// @desc	Holds a pool of objects that can be reused.
function ObjectPool( _new = function() { return {}; } ) constructor {
	/// @param {mixed}	value	An object
	/// @desc	Puts an object into the pool and returns it.
	/// @returns mixed
	static put	= function( _value ) {
		ds_stack_push( __Pool, _value );
		
		return _value;
		
	}
	/// @desc	Returns an object from the pool if it exists.  Otherwise a new object is returned.
	/// @returns mixed
	static get	= function() {
		if ( ds_stack_empty( __Pool ) ) { return __New(); }
		return ds_stack_pop( __Pool );
		
	}
	/// @desc	Returns true if the pool is empty.
	/// @returns bool
	static is_empty	= function() {
		return ds_stack_empty( __Pool );
		
	}
	/// @param {method}	func	A function
	/// @desc	Frees the objects in the pool.  If `func` is provided, each item will be passed
	///		into the function.
	/// @returns self
	static free		= function( _f = function(){} ) {
		var _i = 0; repeat( ds_stack_size( __Pool ) ) {
			_f( ds_stack_pop( __Pool ));
			
		}
		return self;
		
	}
	/// @param {method}	func	A function
	/// @desc	Destroys the internal stack.  If `func` is provided, each item will be passed
	///		into the function.
	/// @returns self
	static destroy	= function( _f ) {
		free( _f );
		
		ds_stack_destroy( __Pool );
		
		return self;
		
	}
	__New	= _new;
	__Pool	= ds_stack_create();
	
}
