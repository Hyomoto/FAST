#macro FAST		( FASTManager() )

if ( FAST_DISABLE_EVENTS != true ) {
	room_instance_add( room_first, 0, 0, __FASTtool );
	
}
/// @desc	FASTManager is a wrapper for internal FAST system functions.  It provides hooks for the
//		event system.
function FASTManager() {
	static manager	= function() constructor {
		static CREATE		= ds_list_create();
		static GAME_END		= ds_list_create();
		static ROOM_START	= ds_list_create();
		static ROOM_END		= ds_list_create();
		static STEP_BEGIN	= ds_list_create();
		static STEP			= ds_list_create();
		static STEP_END		= ds_list_create();
		static ASYNC_SYSTEM	= ds_list_create();
		
		NEXT_STEP	= STEP_BEGIN;
		
		/// @func call_events()
		/// @desc	updates the events in the given list and removes them if complete
		static call_events	= function( _list ) {
			var _i = 0; repeat( ds_list_size( _list ) ) {
				_list[| _i++ ].update();
				
			}
			repeat( discard.size() ) {
				var _e	= discard.dequeue();
				var _l	= _e.list;
				var _p	= ds_list_find_index( _l, _e );
				
				if ( _p > -1 ) {
					ds_list_delete( _l, _p );
					
				}
				
			}
			
		}
		static toString	= function() {
			return "FAST " + __FAST_version + ", " + __FAST_date + " by Devon Mullane";
			
		}
		version		= runtime_version_as_struct( __FAST_version );
		runtime		= runtime_version_as_struct( GM_runtime_version );
		date		= __FAST_date;
		features	= ds_list_create();
		discard		= new DsQueue();
		start		= false;
		
	}
	static instance = new manager();
	return instance;
	
}
