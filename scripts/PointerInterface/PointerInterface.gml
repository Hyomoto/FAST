/// @func PointerInterface
/// @param input
/// @param *shape
function PointerInterface( _shape ) constructor {
	static Element	= function( _target, _depth, _interface ) constructor {
		static toString	= function() {
			return string( depth );
			
		}
		static enter	= function() {}
		static leave	= function() {}
		static step		= function() {}
		
		target		= _target;
		depth		= _depth;
		interface	= _interface;
		
	}
	static disable	= function() {
		disabled	= true;
		
		leave();
		
	}
	static enable	= function() {
		disabled	= false;
		
	}
	static inside	= function( _x, _y ) {
		return shape.inside( _x, _y );
		
	}
	static enter	= function() {
		active	= true;
		
	}
	static leave	= function() {
		active	= false;
		target	= noone;
		
		if ( last == undefined ) { return; }
		
		last.leave();
		
		last	= undefined;
		
	}
	static seek		= function( _id ) {
		var _i = size - 1; repeat( size ) {
			if ( objects[ _i ].target == _id ) {
				return objects[ _i ];
				
			}
			--_i;
			
		}
		return undefined;
		
	}
	static set_enter	= function( _id, _enter ) {
		var _index	= seek( _id );
		
		if ( _index != undefined ) {
			_index.enter	= method( _index.target, _enter );
			
		}
		
	}
	static set_leave	= function( _id, _leave ) {
		var _index	= seek( _id );
		
		if ( _index != undefined ) {
			_index.leave	= method( _index.target, _leave );
			
		}
		
	}
	static set_step	= function( _id, _step ) {
		var _index	= seek( _id );
		
		if ( _index != undefined ) {
			_index.step	= method( _index.target, _step );
			
		}
		
	}
	static set_depth	= function( _id, _depth ) {
		var _index	= seek( _id );
		
		if ( _index != undefined ) {
			_index.depth	= _depth;
			
			set_dirty();
			
		}
		
	}
	static sort	= function() {
		array_quicksort( objects, 0, size - 1, false,
			function( _value ) { return _value.depth },
			function( _value, _pivot, _ascending ) {
				return ( _ascending ? _value.depth <= _pivot : _value.depth >= _pivot );
				
			}
		);
		if ( dirty != undefined ) {
			dirty	= dirty.discard();
			
		}
		
	}
	static remove	= function( _id ) {
		var _i = 0; repeat( size ) {
			if ( objects[ _i ].target == _id ) {
				var _hold	= objects;
				
				objects	= array_create( array_length( _hold ), noone );
				
				if ( _i > 0 ) {
					array_copy( objects, 0, _hold, 0, _i );
					
				}
				if ( _i + 1 < size ) {
					array_copy( objects, _i, _hold, _i + 1, size - _i );
					
				}
				--size;
				
				break;
				
			}
			++_i;
			
		}
		
	}
	static add		= function( _id, _depth, _interface ) {
		if ( size == array_length( objects ) ) {
			var _hold	= objects;
			
			objects	= array_create( ceil( array_length( _hold ) * 2 ), noone );
			
			array_copy( objects, 0, _hold, 0, size );
			
		}
		objects[ size++ ]	= new Element( _id, _depth, _interface );
		
		set_dirty();
		
	}
	static set_dirty	= function() {
		if ( dirty =! undefined || size <= 1 ) { return; }
		
		dirty	= event_create( FAST.NEXT_STEP, 0, undefined, function() {
			sort();
		}, true );
		
	}
	static update	= function( _x, _y ) {
		var _rx	= _x - shape.x;
		var _ry = _y - shape.y;
		
		// if this interface is disabled, or position is not within, no selection
		if ( disabled || inside( _x, _y ) == false ) { return noone; }
		if ( last != undefined && last.target.inside( _rx, _ry ) == false ) {
			last.leave();
			last	= undefined;
			target	= noone;
			
		}
		// search objects
		var _object, _i = 0; repeat( size ) {
			// get next target
			_object	= objects[ _i++ ];
			// if position is inside of target
			if ( _object.target.inside( _rx, _ry ) ) {
				// if previous target is no longer valid
				if ( last != _object ) {
					_object.enter();
					
					target	= _object.target;
					last	= _object;
					
				} else {
					last.step();
					
				}
				// if target is an interface, seek nested target
				if ( _object.interface ) {
					target	= _object.target.update( _x, _y );
					
				}
				break;
				
			}
			
		}
		return target;
		
	}
	static toString	= function() {
		return "Shape : " + instanceof( shape ) + ", Active : " + string( active ) + ", Target : " + string( target );
		
	}
	shape	= ( _shape == undefined ? new Shape() : _shape );
	dirty	= undefined;
	disabled= false;
	objects	= array_create( 5, noone );
	size	= 0;
	target	= noone;
	last	= undefined;
	active	= false;
	
}
