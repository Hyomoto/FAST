/// @func PublisherManager
/// @wiki Publisher-Index
function PublisherManager(){
	static instance	= new Feature( "FAST Observer", "1.1", "07/10/2020", new Publisher() );
	
	return instance.struct;
	
}
