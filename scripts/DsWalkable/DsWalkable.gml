/// @func DsWalkable
/// @param values...
/// @desc A garbage-collected, linear-traversable linked-list with state memory. DsWalkable is designed
///		for iterable data that is designed to be read in one direction, such as a list of points in a
///		path. Reading past the end will result in the list looping, thus it will reset itself once it has
///		been read through fully, otherwise start() must be called to reset.
/// @example
//walker = new DsWalkable( 1, 2, 3, 4, 5 );
//
//while( walker.has_next() ) {
//  show_debug_message( walker.next() );
//}
/// @wiki Core-Index Data Structures
function DsWalkable() : DsLinkedList() constructor {
	/// @override
	static clear_DsLinkedList	= clear;
	/// @override
	static clear	= function() {
		clear_DsLinkedList();
		
		step	= undefined;
		steps	= 0;
		
	}
	/// @param {int} at optional: The index to start at. Default: 0
	/// @desc Starts the list at the given entry.
	static start	= function( _at ) {
		step	= undefined;
		steps	= 0;
		repeat ( (is_undefined( _at ) ||
								_at >= size() ||
								_at < 0)
				? 0 : _at) { next(); }
		
	}
	/// @desc Returns `true` if the list has not yet reached the end
	/// @returns bool
	static has_next	= function() {
		return ( links == 0 ? false : step == undefined || step.chain != undefined );
		
	}
	/// @desc Returns the number of links remaining in the list
	/// @returns intp
	static remaining	= function() {
		return links - steps;
		
	}
	/// @desc Returns the next value in the list
	/// @returns Mixed
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
	/// @desc Returns the value at the current read position without advancing it
	/// @returns Mixed
	static peek	= function() {
		if ( links == 0 ) { return undefined; }
		
		return ( step == undefined ? chain.value : step.value );
		
	}
	static is		= function( _data_type ) {
		return _data_type == DsWalkable;
		
	}
	/// @desc the current link being read, or `undefined` if the list has not started yet
	step	= undefined;
	/// @desc the number of steps that have been taken through the list
	steps	= 0;
	
	var _i = 0; repeat( argument_count ) {
		add( argument[ _i++ ] );
		
	}
	
}
