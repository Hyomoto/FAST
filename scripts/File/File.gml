/// @desc A generic file handling constructor.
function File() constructor {
	 /// @param {Constant.BufferDataType} _type Default: buffer_text
    /// @desc Reads the next portion of the file and returns it. Throws an exception if the file is not open for reading.
    static read = function( _type = buffer_text ) {
		if ( not isOpen() || mode != "r" )
			throw new Exception("File.read : The file is not open for reading.");
        return buffer_read( instance, _type );
		
    }
    
    /// @param {Any} _value A value to write.
    /// @param {Constant.BufferDataType} _type Default: auto-determined
    /// @desc Writes the given values to the file. Converts non-string values to appropriate types. Throws an exception if the file is not open for writing.
    static write = function( _value, _type = undefined ) {
        if ( not isOpen() && mode == "r" )
			throw new Exception("File.read : The file is not open for writing.");
		if ( is_undefined( _type )) {
			if ( is_string( _value )) _type	= buffer_string;
			else if ( is_numeric( _value )) _type = buffer_f64;
			else {
				_value	= string( _value );
				_type	= buffer_string;
				
			}
			
		}
		buffer_write( instance, _type, _value );
		
        return self;
        
    }
    
	/// @param {string} _mode The action to take. 'r' - read from file, 'w' - write to file, 'n' - new file
	/// @param {string} _filename The name of the file to open.
	/// @desc Opens a file for processing. Throws an exception if the mode is invalid or the filename is not provided when reading.
    static open = function( _mode = mode, _filename = file ) {
		if ( isOpen())
			close();
		
		if ( is_undefined( _filename ))
			throw new Exception( $"File.open : A filename must be specified for reading." );
		
		_mode = string_lower( _mode ?? "w" );
		
        switch ( _mode ) {
            case "r" :
				if ( file_exists( _filename ) == false )
					throw new Exception( $"File.open : File '{ _filename }' not found.");
				instance	= buffer_load( _filename );
				break;
				
            case "w" :
				if ( file_exists( _filename )) {
					instance	= buffer_load( _filename );
					buffer_seek( instance, buffer_seek_end, 0 );
					break;
					
				}
				
			case "n" :
				_mode		= "w";
				instance	= buffer_create( 1, buffer_grow, 1 );
				break;
				
            default:
                throw new Exception( $"File.open : Invalid mode '{ _mode }', expected 'r', 'n' or 'w'.");
			
        }
        file	= _filename;
        mode	= _mode;
        
        return self;
		
    }
    
    /// @desc Closes this file. No further processing can take place unless it is reopened.
    static close = function() {
		if ( isOpen() == false )
			return;
		
		if ( mode == "w" )
			buffer_save( instance, file );
		buffer_delete( instance );
		instance	= -1;
		
        return self;
		
    }
	
	/// @desc Checks if the file is open.
	static isOpen	= function() {
		return instance > -1;
		
	}
	
    /// @desc Returns true if the end of the file has been reached. If the file isn't open, or the file isn't open for reading, an exception will be thrown.
    static isFinished = function() {
        if ( isOpen() && mode == "r" )
            return buffer_tell( instance ) >= buffer_get_size( instance );
        return false;
		
    }
    file		= undefined;
    mode		= undefined;
	instance	= -1;
	
}
