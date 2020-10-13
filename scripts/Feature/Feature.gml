/// @func Feature
/// @param name
/// @param version
/// @param date
/// @param struct
/// @wiki Core-Index
function Feature( _name, _version, _date, _struct ) constructor {
	static toString	= function() {
		return name + " " + version + ", " + date;
		
	}
	name	= _name;
	version	= _version;
	date	= _date;
	struct	= _struct;
	
	ds_list_add( FAST.features, self );
	
}
