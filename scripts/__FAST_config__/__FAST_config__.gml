// # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//								User-definable Macros
// # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//	If set to true, the event system will not be created.  Events can still be used,
//	but they will have to be managed manually.
#macro FAST_DISABLE_EVENTS	false

// # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// #							End of User Defines
// # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#macro FAST			( __FAST_config__() )
#macro syslog		( __output_to_stream__() ).write
#macro SystemOutput	( __output_to_stream__() )

#macro __FAST_version__	"3.5.1"
#macro __FAST_date__	"06/23/2021"

#macro EVENT	function()

#macro FAST_FILE_OPEN_READ	0
#macro FAST_FILE_OPEN_WRITE	1
#macro FAST_FILE_OPEN_NEW	2

#macro FAST_EVENT_STEP			FAST.STEP
#macro FAST_EVENT_STEP_BEGIN	FAST.STEP_BEGIN
#macro FAST_EVENT_STEP_END		FAST.STEP_END

#macro FAST_EVENT_CREATE		FAST.CREATE
#macro FAST_EVENT_GAME_START	FAST.GAME_START
#macro FAST_EVENT_GAME_END		FAST.GAME_END
#macro FAST_EVENT_ROOM_START	FAST.ROOM_START
#macro FAST_EVENT_ROOM_END		FAST.ROOM_END
#macro FAST_ASYNC_EVENT			FAST.ASYNC_SYSTEM

if ( FAST_DISABLE_EVENTS != true ) {
	room_instance_add( room_first, 0, 0, __FASTtool );
	
}

/// @func __output_to_stream__
/// @desc	__output_to_stream__ is a wrapper for the common console output in the GMS IDE. It instantiates
//		itself when called and uses the SystemOutput and syslog macros as simple references. To write
//		to the console simply call `syslog()`.  SystemOutput is an {#__OutputStream__} and can be
//		used as a valid target for functions that write to an output stream.
function __output_to_stream__() {
	static instance	= ( function() {
		var _output	= new __OutputStream__();
		
		_output.write	= method( _output, function() {
			__Buffer	= "";
			
			var _i = -1; repeat( argument_count ) { ++_i;
				__Buffer	+= string( argument[ _i ] );
				
			}
			show_debug_message( __Buffer );
			
		});
		return _output;
		
	})();
	return instance;
	
}
/// @desc	FASTManager is a wrapper for internal FAST system functions.  It provides hooks for the
//		event system.
function __FAST_config__() {
	static instance = new ( function() constructor {
		static CREATE		= ds_list_create();
		static GAME_START	= ds_list_create();
		static GAME_END		= ds_list_create();
		static ROOM_START	= ds_list_create();
		static ROOM_END		= ds_list_create();
		static STEP_BEGIN	= ds_list_create();
		static STEP			= ds_list_create();
		static STEP_END		= ds_list_create();
		static ASYNC_SYSTEM	= ds_list_create();
		
		__Events__	= [ CREATE, GAME_START, GAME_END, ROOM_START, ROOM_END, STEP_BEGIN, STEP, STEP_END, ASYNC_SYSTEM ];
		
		NEXT_STEP	= STEP_BEGIN;
		
		static log	= SystemOutput;
		/// @func call_events()
		/// @desc	updates the events in the given list and removes them if complete
		static call_events	= function( _list ) {
			var _i = 0; repeat( ds_list_size( _list ) ) {
				_list[| _i++ ].update();
				
			}
			repeat( ds_queue_size( discard )) {
				var _e	= ds_queue_dequeue( discard );
				var _l	= _e.__Event;
				var _p	= ds_list_find_index( _l, _e );
				
				if ( _p > -1 ) {
					ds_list_delete( _l, _p );
					
				}
				
			}
			
		}
		static feature	= function( _tag, _name, _version, _date) {
			if ( variable_struct_exists( features, _tag ) ) {
				log.write( "FAST :: ", _tag, " already defined with version ", features[$ _tag ].version(), " and replaced " +
					 "with version " + string_con( ( _version >> 32 ) & 0xFF, ".", ( _version >> 16 ) & 0xFF, ".", _version & 0xFF ) + "." );
				
			}
			features[$ _tag ]	= {
				toString: function() {
					return __Name + " v" + version() + ", " + __Date;
				},
				version: function() {
					return string_con( ( __Vers >> 32 ) & 0xFF, ".", ( __Vers >> 16 ) & 0xFF, ".", __Vers & 0xFF )
					
				},
				__Name	: _name,
				__Vers	: _version,
				__Date	: _date
				
			};
			flength	= max( flength, string_length( _name ) );
			
		}
		static toString	= function( _features ) {
			static __B__	= string_repeat( "~", 40 );
			
			if ( _features == true ) {
				var _string	= __B__ + "\n" + toString() + "\n" + __B__ + "\n"
				var _list	= variable_struct_get_names( features );
				
				var _i = 0; repeat( array_length( _list ) ) {
					var _f	= features[$ _list[ _i++ ] ];
					
					_string	+= _f.__Name + string_repeat( " ", flength - string_length( _f.__Name )) + " v" + _f.version() + " " + _f.__Date + "\n";
					
				}
				return _string;
				
			}
			return "FAST " + __FAST_version__ + ", " + __FAST_date__ + " by Devon Mullane";
			
		}
		features	= {};
		flength		= 0;
		discard		= ds_queue_create();
		start		= false;
		
	})();
	return instance;
	
}

/// @func IndexOutOfBounds
/// @desc	Thrown when a call is made to index a data structure that is out of bounds
/// @wiki Core-Index Errors
function IndexOutOfBounds( _call, _index, _bounds ) : __Error__() constructor {
	message	= conc( "The provided index(", _index, ") to function \"", _call, "\" was out of range(size was ", _bounds, ")." )
}
/// @func ValueOutOfBounds
/// @desc	Thrown when a call is made a value that is outside of an acceptible range
/// @wiki Core-Index Errors
function ValueOutOfBounds( _call, _value, _low, _high ) : __Error__() constructor {
	message	= conc( "The provided value(", _value, ") to function \"", _call, "\" was out of range(expects ", _low, " >= value >= ", _high, ")." )
}
/// @func ValueNotFound
/// @desc	Returned when a search is made for a value that doesn't exist in a data structure.
/// @wiki Core-Index Errors
function ValueNotFound( _call, _value, _index ) : __Error__() constructor {
	message	= conc( "The value(", _value, ") provided to function \"", _call, "\" didn't exist in the structure." );
	index	= _index;
}
/// @func InvalidArgumentType
/// @desc	Thrown when an argument is provided of the wrong type.
/// @wiki Core-Index Errors
function InvalidArgumentType( _call, _arg, _value, _expected ) : __Error__() constructor {
	message	= conc( "The value(", _value, ") provided as argument ", _arg, " to function \"", _call, "\" was of the wrong type(got ", typeof( _value ), ", expected ", _expected, ")" );
}
/// @func UnexpectedTypeMismatch
/// @desc	Thrown when a value is returned legally, but is not of the type expected.
/// @wiki Core-Index Errors
function UnexpectedTypeMismatch( _call, _value, _expected ) : __Error__() constructor {
	message	= conc( "The function ", _call, " expected type of ", _expected, " but recieved ", typeof( _value ), "." );
}
/// @func BadJSONFormat
/// @desc	Thrown when a JSON string is provided that can not be properly converted into an expected type.
/// @wiki Core-Index Errors
function BadJSONFormat( _call ) : __Error__() constructor {
	message	= conc( "The function ", _call, " expected a JSON string, but it could not be converted." );
}
/// @func BadValueFormat
/// @desc	Thrown when a value could not be converted into an expected type.
/// @wiki Core-Index Errors
function BadValueFormat( _call, _type, _extra ) : __Error__() constructor {
	message	= conc( "The function ", _call, " failed to perform the expected type conversion to ", _type ,". ", _extra );
}
/// @func FileNotFound
/// @desc	Thrown when a request for a file is made and it didn't exist.
function FileNotFound( _call, _file ) : __Error__() constructor {
	message	= conc( "The function ", _call, " failed because it could not find ", _file )
}
/// @func IllegalFileOperation
/// @desc	Thrown when an illegal call is made to operate on a file.
function IllegalFileOperation( _call, _msg ) : __Error__() constructor {
	message	= conc( "The function ", _call, " failed because ", _msg )
}
/// @func ReservedKeyword
/// @desc	Thrown when a call is made to use a keyword that is reserved.
/// @wiki Core-Index Errors
function ReservedKeyword( _call, _value ) : __Error__() constructor {
	message	= conc( "The function ", _call, " failed because ", _value, " is a reserved keyword." );
}
/// @func IllegalStreamOperation
/// @desc	Thrown when an illegal call is made to operate on a stream.
function IllegalStreamOperation( _call, _msg ) : __Error__() constructor {
	message	= conc( "The function ", _call, " failed because ", _msg )
}
