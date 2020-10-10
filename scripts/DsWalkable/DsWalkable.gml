/// @func DsWalkable
function DsWalkable() : DsLinkedList() constructor {
// # Method Declaration
	static clear_DsLinkedList	= clear;
	static clear	= function() {
		clear_DsLinkedList();
		
		step	= undefined;
		steps	= 0;
		
	}
	static start	= function( _at ) {
		step	= undefined;
		steps	= 0;
		
		jump( is_undefined(_at) ? -1 : _at );
		
	}
	static jump	= function( _index ) {
		if ( _index > links || _index < 0) { return undefined; }
		step	= undefined;
		steps	= 0;
		
		repeat( _index ) { next(); }
	}
	
	static has_next	= function() {
		return ( links == 0 ? false : step == undefined || step.chain != undefined );
		
	}
	static remaining	= function() {
		return links - steps;
		
	}
	static next		= function() {
		if ( links == 0 ) { return undefined; }
		if ( step == undefined || step.chain == undefined ) {
			step	= chain;
			steps	= 1;
			
		} else {
			step	= step.chain;
			steps	+= 1;
			
		}
		return step.value;
		
	}
	static peek	= function() {
		if ( links == 0 ) { return undefined; }
		
		return ( step == undefined ? chain.value : step.value );
		
	}
	static poke	= function( _value ) {
		// insert a value at the current read position
	}
	
	static is		= function( _data_type ) {
		return _data_type == DsWalkable;
		
	}
// # Variable Declaration
	step	= undefined;
	steps	= 0;
	
	var _i = 0; repeat( argument_count ) {
		add( argument[ _i++ ] );
		
	}
	
}