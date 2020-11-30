/// @func GarbageManager
/// @desc	Tracks reported data types and destroys them when they no longer exist.  The collector is
//		generational.  Anything created _this_ frame will be checked and cleaned up if it goes missing,
//		otherwise it is promoted to generation 1.  Only one item in generation 1 is checked each frame,
//		so it make take many frames before something is cleaned up, especially if a high number of
//		tracked items exist.
function GarbageManager() {
	static manager	= function( _rate ) constructor {
		static log	= function() {
			static logger	= new Logger( "garbage", FAST_LOGGER_DEFAULT_LENGTH, System );
			
			var _string	= "";
			
			var _i = 0; repeat( argument_count ) {
				_string	+= string( argument[ _i++ ] );
				
			}
			logger.write( _string );
			
		}
		static destroy	= function( _gen, _index ) {
			_gen[ _index ].destroy( _gen[ _index ].pointer );
			
			array_delete( gen1, _index, 1 );
			
		}
		static promote	= function( _index ) {
			array_push( gen1, gen0[ _index ] );
			array_delete( gen0, _index, 1 );
			
		}
		static add	= function( _target, _pointer, _method ) {
			var _ref	= {
				destroy : method( self, _method ),
				pointer	: _pointer,
				ref		: weak_ref_create( _target )
				
			};
			array_push( gen0, _ref );
			
		}
		static toString	= function() {
			return string_con( "Garbage :: Gen0( ", array_length( gen0 ), " ), Gen1( ", array_length( gen1 ), " )" );
			
		}
		gen0	= [];
		gen1	= [];
		cycle	= 0;
		
		event	= new FrameEvent( FAST.STEP, _rate, undefined, function() {
			if ( array_length( gen1 ) > 0 ) {
				if ( weak_ref_alive( gen1[ cycle ].ref ) ) {
					++cycle
					
				} else {
					destroy( gen1, cycle );
					
				}
				if ( cycle >= array_length( gen1 ) ) { cycle = 0; }
				
			}
			repeat( array_length( gen0 ) ) {
				if ( weak_ref_alive( gen0[ 0 ].ref ) ) {
					promote( 0 );
					
				} else {
					destroy( gen0, 0 );
					
				}
				
			}
			
		});
		
	}
	static instance	= new Feature( "FAST Garbage", "1.0", "10/20/2020", new manager( argument_count == 0 ? 1 : argument[ 0 ] ) );
	return instance.struct;
	
}
