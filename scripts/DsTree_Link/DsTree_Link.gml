/// @func DsTree_Link
/// @param value
function DsTree_Link( _value ) : DsTree_Value( _value ) constructor {
	static copy	= function() {
		return self;
		
	}
	base		= DsTree_Link;
	type		= "node";
	
}
