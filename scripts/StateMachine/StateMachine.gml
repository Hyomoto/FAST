function StateMachine() constructor {
	/// @param {Function} _onStep
	/// @param {Function} _onEnter
	/// @param {Function} _onExit
	/// @returns {Struct.State}
	static create	= function( _onStep = function() {}, _onEnter = undefined, _onExit = undefined ) {
		return new State( _onStep, _onEnter, _onExit );
		
	}
	/// @param {Struct.State} _state
	static set	= function( _state, _onEnter = true, _onExit = true ) {
		if ( _onExit && state != undefined && state.onExit != undefined )
			state.onExit();
		
		state	= _state;
		
		if ( _onEnter && _state != undefined && _state.onEnter != undefined )
			_state.onEnter();
		return self;
		
	}
	static pop	= function() {
		if ( isEmpty())
			set( undefined );
		else {
			var _state	= array_pop( stack );
			set( _state[ 0 ], _state[ 1 ], _state[ 2 ] );
			
		}
		return self;
		
	}
	/// @param {Struct.State} _state
	static push	= function( _state, _onEnter = true, _onExit = true ) {
		array_push( stack, [ state, _onEnter, _onExit ] );
		set( _state );
		return self;
		
	}
	static clear	= function() {
		stack	= [];
		return self;
		
	}
	static update	= function( _delta ) {
		if ( state != undefined )
			state.onStep( _delta );
		return self;
		
	}
	static after	= function() {
		if ( state.onAnim != undefined )
			state.onAnim();
		return self;
		
	}
	static isEmpty	= function() {
		return array_length( stack ) == 0;
		
	}
	/// @param {Struct.State} _state
	static is	= function( _state ) {
		return state == _state;
		
	}
	stack	= [];
	state	= undefined;
	
}
