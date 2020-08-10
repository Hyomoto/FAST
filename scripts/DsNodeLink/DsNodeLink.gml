/// @func DsNodeLink
/// @param value
function DsNodeLink( _value ) : DsNodeValue( _value ) constructor {
	static copy	= function() {
		return self;
		
	}
	base		= DsNodeLink;
	type		= "value";
	
}
