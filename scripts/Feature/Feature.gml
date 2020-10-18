/// @func Feature
/// @param {string}	name	The name of the feature being created.
/// @param {string}	version	The version of the feature being created.
/// @param {string}	date	The date the feature was created.
/// @param {struct}	struct	A structure of data that will be returned.
/// @desc	The Feature constructor is an interface for creating instantiate-on-demand constructors
//		that plug into the FAST framework. Most modules use it to declare themselves as well as
//		create themselves a Logger and any other library functions associated with it. This allows
//		reducing namespace clutter, as well as providing a private-like wrapper for your constructor
//		method. The general format for creating a feature is:
/// @example
//function MyFeature() {
//  static feature	= function() constructor {
//    static log	= function( _value ) {
//      static logger	= new Logger( "myfeature", 144, System );
//      logger.write( _value );
//    }
//	}
//  static instance = new Feature( "MyFeature", "1.0", "10/10/1010", new feature() );
//  return instance.struct;
//}
/// @wiki Core-Index
function Feature( _name, _version, _date, _struct ) constructor {
	static toString	= function() {
		return name + " " + version + ", " + date;
		
	}
	// @desc The name of the feature.
	name	= _name;
	// @desc The version of the feature.
	version	= _version;
	// @desc The date of the feature.
	date	= _date;
	// @desc The struct provided, and what should be returned by the feature wrapper function.
	struct	= _struct;
	
	ds_list_add( FAST.features, self );
	
}
