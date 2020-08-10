/// @func DsStack
/// @param values...
function DsStack() : DsChain() constructor {
	/// @func push
	/// @param values...
	static push	= function() {
		var _i = 0; repeat( argument_count ) {
			add( argument[ _i++ ] );
			
		}
		
	}
	static top	= function() {
		if ( tail == undefined ) { return undefined; }
		
		return tail.value;
		
	}
	static pop	= function() {
		var _seek	= tail;
		
		if ( _seek == undefined ) { return undefined; }
		
		remove( _seek );
		
		return _seek.value;
		
	}
	var _i = 0; repeat( argument_count ) {
		add( argument[ _i++ ] );
		
	}
	
}
