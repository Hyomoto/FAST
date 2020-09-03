/// @func PublisherManager
function PublisherManager(){
	static manager	= function() constructor {
		
		
	}
	static instance	= new Feature( "FAST Observer", "1.1", "07/10/2020", new manager() );
	
	return instance.struct;
	
}
