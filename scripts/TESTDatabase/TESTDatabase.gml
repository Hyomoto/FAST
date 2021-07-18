/// @func TESTDatabase
function TESTDatabase() : __Struct__() constructor {
	static __pool__	= new ObjectPool();
	static __node__	= function( _value, _type ) constructor {
		static read	= function( _path ) { 
			
		}
		static write	= function( _path, _value, _id ) {
			
		}
		static remove	= function( _path ) {
			
		}
		static __parser__	= new ( __FAST_database_config__().parser )(".");
		
	}
	__Type__.add( Database );
	
}
