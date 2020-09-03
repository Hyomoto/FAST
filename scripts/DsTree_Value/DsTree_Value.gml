/// @func DsTree_Value
/// @param value
function DsTree_Value( _value ) constructor {
	static destroy	= function() {}
	static is	= function( _type ) {
		return type == _type;
		
	}
	static copy	= function( _target ) {
		if ( _target != undefined && _target.type == type ) {
			_target.value	= value;
			
			return _target;
			
		}
		var _new	= new base( value );
		
		_new.writable	= writable;
		_new.type		= type;
		
		return _new;
		
	}
	static lock		= function() {
		writable	= false;
		
	}
	static unlock	= function() {
		writable	= true;
		
	}
	static is		= function( _data_type ) {
		return _data_type == DsTree_Value;
		
	}
	static toString	= function() {
		return string( value ) + " (" + type + ")";
		
	}
	static total	= 0;
	
	base		= DsTree_Value;
	value		= _value;
	writable	= true;
	type		= "value";
	unique		= total++;
	
}
