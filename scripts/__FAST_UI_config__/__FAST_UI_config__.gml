// # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//								User-definable Macros
// # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

// # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// #							End of User Defines
// # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
FAST.feature( "FGUI", "User Interface", (0 << 32 ) + ( 0 << 16 ) + 1, "07/11/2021" );

#macro InterfaceManager	(__FAST_UI_config__())

function __FAST_UI_config__(){
	static instance	= new ( function() constructor {
		static from_string	= function( _string ) {
			from_input( new String( _string ));
			
		}
		static from_input	= function( _input ) {
			var _root	= {};
			
			__parser__.open( _input );
			
			while( __parser__.finished() == false ) {
				
				
			}
			
		}
		static __parser__	= new Parser();
		
	})();
	return instance;
	
}
//InterfaceManager.from_string(@"
//img:
//	name: bg
//	source: gfx_fast2
//img:
//	source: gfx_FAST_watch
//img:
//	source: gfx_fast
//div:
//	name: box
//	source:
//		img:
//			source: gfx_ATS_box
//		list:
//			name: console
//");