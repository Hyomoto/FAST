/// @func DsTree_Branch
/// @param value
function DsTree_Branch( _value ) : DsTree_Value( _value ) constructor {
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
	base		= DsTree_Branch;
	type		= "node";
	
}
