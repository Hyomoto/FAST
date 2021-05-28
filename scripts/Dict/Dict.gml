/// @func Dict
/// @desc	Creates a dictionary-type structure. Will be cleaned up automatically once the reference is lost.
/// @wiki Core-Index Data Structures

function Dict() constructor {
	
	/// @param {string}	key	The key that will be used to set this value. Non-Strings will be converted.
	/// @param {mixed}	value	The value to be assigned to the key.
	/// @desc Set the specified key-value pair.
	static set = function(k, v) {
		variable_struct_set(__Lookup, string(k), v);	
	}
	
	/// @param {string}	key	The key that will be used to get the value of the key-value pair. Non-Strings will be converted.
	/// @param {mixed}	value	The value to be returned if the key-value pair does not exist.
	/// @desc Get the specified key-value pair.
	/// @returns mixed
	static get = function(k, v) {
		var _v = variable_struct_get(__Lookup, string(k));
		return is_undefined(_v) ? v : _v;
	}
	
	/// @param {string}	key	The key that will be used to check whether the key-value pair exists. Non-Strings will be converted.
	/// @desc Get if the key-value pair exists.
	/// @returns bool
	static exists = function(k) {
		return is_undefined( get(k) );
	}
	
	/// @desc Get the dict size.
	/// @returns integer
	static size = function() {
		return variable_struct_names_count(__Lookup);
	}
	/// @desc Get if the dict is empty.
	/// @returns bool
	static empty = function() {
		return size() == 0;	
	}
	
	/// @param {string}	key	The key that will be used to remove the key-value pair. Non-Strings will be converted.
	/// @desc Removes the specified key-value pair.
	static remove = function(k) {
		variable_struct_remove(__Lookup, string(k))	
	}
	
	/// @desc Get the dict keys.
	/// @returns array
	static keys_toArray = function() {
		return variable_struct_get_names(__Lookup);
	}
	
	/// @desc Get the dict values.
	/// @returns array
	static values_toArray = function() {
		var _temp = array_create( size() );
		var _keys = keys_toArray();
		
		var i = -1; repeat( size() ) { i++;
			_temp[i] = get(_keys[i]); 
		}
		return _temp;
	}
	
	/// @desc Get the dict key-value pairs.
	/// @returns array
	static toArray = function() {
		var _temp = array_create( size() );
		var _keys = keys_toArray();
		
		var i = -1; repeat( size() ) { i++;
			_temp[i] = [_keys[i], get(_keys[i])]; 
		}
		return _temp;
	}
	
	//internal dict
	__Lookup = {};
	
}