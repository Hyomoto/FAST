// # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//								User-definable Macros
// # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//		Provides a wrapper for GMS internal functions to prevent arbitrary code injection
//	by simply assigning an index to a variable and then running it.  If set to false this
//	check is not performed but the system will otherwise behave the same.  There is a
//	to no performance benefit to turning this off.
#macro FAST_SCRIPT_PROTECT_FUNCTIONS	true

// # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// #							End of User Defines
// # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#macro FAST_SCRIPT_RETURN			0x0
#macro FAST_SCRIPT_YIELD			0x1

enum FAST_SCRIPT_FLAG {
	OPENBRACKET, // 0
	CLOSEBRACKET,// 1
	
	POSITIVE,	 // 2
	NEGATIVE,	 // 3
	
	PLUS,		// 4
	MINUS,		// 5
	TIMES,		// 6
	DIVIDE,		// 7
	
	GREATERTHAN,		// 8
	GREATERTHANOREQUAL,	// 9
	LESSTHAN,			// 10
	LESSTHANOREQUAL,	// 11
	EQUAL,				// 12
	NOTEQUAL,			// 13
	
	AND,		// 14
	OR,			// 15
	NOT,		// 16
	
	NUMBER,		// 17
	STRING,		// 18
	VARIABLE,	// 19
	FUNCTION,	// 20
	
	NoInfo,
	SkipClimbUp,
	RightAssociative,
	
}
enum FAST_SCRIPT_CODE {
	IF,		// 0
	ELSE,	// 1
	WHILE,	// 2
	RETURN,	// 3
	YIELD,	// 4
	TEMP,	// 5
	PUT,	// 6
	LOAD,	// 7
	EXECUTE,	// 8
	LAST_BYTE
}
enum FAST_SCRIPT_INDEX {
	INDENT,
	JUMPTO,
	INSTRUCTION,
	DATA,
	DEBUG_LINE
}
/// @func BadScriptFormat
/// @desc	Returned when a search is made for a value that doesn't exist in a data structure.
/// @wiki Core-Index Errors
function BadScriptFormat( _type, _source, _line_number, _line ) : __Error__() constructor {
	message	= conc( _type, " at line ", _line_number, " in " + _source + "!\n>> " + _line);
}

FAST.feature( "FSCR", "Scripting", __FAST_script_config__().version , "6/20/2021" );

function __FAST_script_config__() {
	static instance	= new ( function() constructor {
		static parser	= function( _char ) constructor {
			static parse	= function( _string ) {
				__String	= _string;
				__Size		= string_length( _string );
				__Last		= 0;
				__Count		= string_count( __Char, _string );
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
					return _c;
					
				}
				var _c	= string_copy( __String, __Last + 1, _i - __Last - 1 );
				
				__Last	= _i;
				
				return _c;
				
			}
			static peek	= function() {
				var _h	= __Last;
				var _c	= next();
				__Last	= _h;
				
				return _c;
				
			}
			__Char	= _char;
			__Last	= 0;
			__Size	= 0;
			__String= "";
		};
		version		= (0 << 32 ) + (1 << 16);
		
	})();
	return instance;
	
}