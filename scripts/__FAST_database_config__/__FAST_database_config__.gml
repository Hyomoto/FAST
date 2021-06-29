// # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//								User-definable Macros
// # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

// # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// #							End of User Defines
// # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
enum FAST_DB_IDS {
	NODE,
	STRING,
	NUMBER,
	ARRAY,
	STRUCT,
	LAST
}
enum FAST_DB {
	NORMAL,
	DEFINE
}

FAST.feature( "FTDB", "Database", (2 << 32 ) + ( 0 << 16 ) + 0, "06/23/2021" );

/// @func __FAST_input_config__
function __FAST_database_config__() {
	static instance	= new ( function() constructor {
		static parser	= function( _char ) constructor {
			static parse	= function( _string ) {
				__String	= _string;
				__Size		= string_length( _string );
				__Last		= 0;
				__Count		= string_count( __Char, _string );
				
				return self;
				
			}
			static count	= function() {
				return __Count;
				
			}
			static has_next	= function() {
				return __Last < __Size;
				
			}
			static next	= function() {
				var _i	= string_pos_ext( __Char, __String, __Last );
				
				if ( _i == 0 ) {
					var _c = string_delete( __String, 1, __Last );
					__Last	= __Size;
					__Buffer	= _c;
					return _c;
					
				}
				var _c	= string_copy( __String, __Last + 1, _i - __Last - 1 );
				
				__Last		= _i;
				__Buffer	= _c;
				
				return _c;
				
			}
			static peek	= function() {
				var _h	= __Last;
				var _c	= next();
				__Last	= _h;
				
				return _c;
				
			}
			__Buffer= "";
			__Char	= _char;
			__Last	= 0;
			__Size	= 0;
			__String= "";
			
		};
		
	})();
	return instance;
	
}
/// @func BadDatabaseFormat
/// @desc	Returned when the database fails to read from an input.
/// @wiki Database Errors
function BadDatabaseFormat( _value, _msg ) : __Error__() constructor {
	message	= f( "Could not read {}, {}", _value, _msg );
}
