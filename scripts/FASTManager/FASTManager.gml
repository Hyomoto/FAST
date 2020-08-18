#macro FAST		( FASTManager() )

room_instance_add( room_first, 0, 0, __FASTtool );

function FASTManager() {
	static manager	= function() constructor {
		static CREATE		= ds_list_create();
		static GAME_END		= ds_list_create();
		static ROOM_START	= ds_list_create();
		static ROOM_END		= ds_list_create();
		static STEP_BEGIN	= ds_list_create();
		static STEP			= ds_list_create();
		static STEP_END		= ds_list_create();
		
		NEXT_STEP	= STEP_BEGIN;
		
		/// @func delete_event
		/// @param Event
		static delete_event	= function( _event ) {
			var _list	= _event.list;
			
			var _i	= 0; repeat( ds_list_size( _list ) ) {
				if ( _list[| _i++ ] == _event ) {
					ds_list_delete( _list, --_i );
					
					break;
					
				}
				
			}
			
		}
		/// @func call_events()
		/// @desc	updates the events in the given list and removes them if complete
		static call_events	= function( _list ) {
			var _i = 0; repeat( ds_list_size( _list ) ) {
				var _event	= _list[| _i++ ];
				
				if ( ++_event.tick >= _event.tock ) {
					if ( _event.ignore == false ) {
						_event.func( _event.params );
						
					}
					if ( _event.once ) {
						ds_list_delete( _list, --_i );
						
						continue;
						
					}
					_event.tick	= 0;
					
				}
				
			}
			
		}
		static toString	= function() {
			return "FAST " + version + ", " + date + " by Devon Mullane";
			
		}
		version		= __FAST_version;
		date		= __FAST_date;
		features	= ds_list_create();
		
		start		= false;
		
	}
	static instance = new manager();
	return instance;
	
}
