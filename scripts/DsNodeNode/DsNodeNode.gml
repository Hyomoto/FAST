/// @func DsNodeNode
/// @param value
function DsNodeNode( _value ) : DsNodeValue( _value ) constructor {
	static destroy	= function() {
		value.destroy();
		
	}
	static copySuper	= copy;
	static copy	= function( _target ) {
		if ( _target != undefined && _target.base == base ) {
			value.copy( _target );
			
			return _target;
			
		}
		_new	= copySuper();
		
		_new.value	= value.copy();
		
		return _new;
		
	}
	base		= DsNodeNode;
	type		= "node";
	
}
