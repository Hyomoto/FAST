function Dict() constructor {
	__Lookup = {};
	
	static set = function(k, v) {
		variable_struct_set(__Lookup, string(k), v);	
	}
	static get = function(k, v) {
		var _v = variable_struct_get(__Lookup, string(k));
		return is_undefined(_v) ? v : _v;
	}
	
	static size = function() {
		return variable_struct_names_count(__Lookup);
	}
	static empty = function() {
		return size() == 0;	
	}
	
	static remove = function(k) {
		variable_struct_remove(__Lookup, string(k))	
	}
	static keys_toArray = function() {
		return variable_struct_get_names(__Lookup);
	}
	static values_toArray = function() {
		var _temp = array_create( size() );
		var _keys = keys_toArray();
		
		var i = -1; repeat( size() ) { i++;
			_temp[i] = get(_keys[i]); 
		}
		return _temp;
	}
	static toArray = function() {
		var _temp = array_create( size() );
		var _keys = keys_toArray();
		
		var i = -1; repeat( size() ) { i++;
			_temp[i] = [_keys[i], get(_keys[i])]; 
		}
		return _temp;
	}
}