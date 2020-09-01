# FAST v3.3
Flexible Assistant Toolkit for Gamemaker Studio 2 - There are many tasks in GML that seem cumbersome because of inconsistencies and omissions in the internal functions in GML. FAST serves as a platform for extending the language with general-purpose features.  It consists of a lightweight System core and include-on-demand features that can be pruned or added as desired. It includes concrete features like universal mouse, keyboard and gamepad support, automatic resolution handling, and a Lua-like scripting language, to more abstract features such as interface structures to provide common implementation patterns and data structure wrappers that enhance built-in GML features. Because all of FAST's features build on the System core, anyone who wishes to write extensions to the FAST library can be confident that their systems will work seamlessly with other FAST features. Extensibility is the whole point. While FAST contains concrete implementations, they all derive from standard interfaces that can be inherited and extended as desired.
## Compatability
```
IDE     2.3.0.529
Runtime 2.3.0.401
```
## Table of contents
* [Core](#core)

# Core
The Core module of FAST is what all other modules build on top of.
## Features
* [Data Structures](#data-structures)
* [Data Types](#data-types)
* [Events](#events)
* [Functions](#functions)
* [System](#system)
### Data Types
FAST contains a large number of helpful data types, including wrappers for the built-in data structures to make them easier to work with and interfaces to build new structures from.
* [Array](#array)
* [String](#string-string-)
* [Data Structures](#data-structures)
* [Pair](#pair-a-b-)
* [Vec2](#vec2-x-y-)
#### Array
The Array wrapper provides an expanded interface to interact with arrays.
* sort() - An interface to provide sort functionality for arrays.
* size() - Returns the size of the array.
* swap( a, b ) - Swaps element a and b in the array.
* unique() - Returns an array containing all unique entries in the array.
* concat( a ) - Returns an array containing this array concantated with array a.
* difference( a ) - Returns an array containing this array subtracted by array a.
* union( a ) - Returns an array containing all unique entries when concantated with array a.
* contains( a ) - Returns the first position in the array that contains a, or -1 if it doesn't exist.
* set( a, b ) - Sets index a in the array to b, if it exists in the array.
* get( a ) - Returns index a in the array, or undefined if it doesn't exist.
* toArray() - Returns the array.
* toString( a ) - Returns the array as a string with a as the divider.
##### ArrayString
Provides an array wrapper with an expanded interface to interact with arrays full of strings. Implements Array.
* sort( ascending ) - Uses quicksort algorithm to alphabetically sort-in-place the array from A-Z when ascending is true, or Z-A when false.
##### ArrayNumber
Provides an array wrapper with an expanded interface to interact with arrays full of numbers. Implements Array.
* sort( ascending ) - Uses quicksort algorithm to numerically sort-in-place the array in ascending order when ascending is true, or descending when false.
* sum() - Returns the sum of all values in the array.
* average() - Returns the average of all values in the array.
* lowest() - Returns the lowest number in the array.
* highest() - Returns the highest number in the array.
#### String( string )
The String wrapper provides an expanded interface to interact with strings such as formatting.
* formatter( a ) - An overwrittable interface that can be used to format the string when set() is called.
* set( a ) - Sets the string to a as returned from formatter().
* draw( x, y, font, color ) - Draws the string at x, y with the given font and color.
* draw_ext( x, y, font, color, halign, valign ) - Draws the string at x, y with the given font, color and alignments.
* width( a ) - Returns the width of the string in font a.
* height( a ) - Returns the height of the string in font a.
* toArray() - Returns the string as a character array.
* toString() - Returns the string.
##### StringNumber( string, format )
Implements String.
##### StringTime( string, decimals, format )
Formats the string as a time with the given number of decimals and format. Implements String.
* decimals - The number of decimals to use.
* format - ex: "$S seconds"
** $H will be converted into the number of hours
** $M will be converted into the number of minutes, sans hours if provided
** $S will be converted into the number of seconds, sans hours and minutes if provided.
#### Pair( a, b )
A simple garbage-collected, two-value structure. Sets the initial values to a and b.
* equals( a, b ) - Returns if the structure a, b values match a, b.
* equals( Pair ) - Returns if the provided Pair matches this one.
* a - the a value.
* b - the b value.
#### Surface( w, h )
The Surface wrapper provides a simplified interface for dealing with surfaces. They can be set to redraw periodically, or only on request.  A surface will always redraw if it is flushed from VRAM.
```GML
if ( surface.update() ) {
  surface.set();
    draw_text( 10, 10, "Hello World!" );
  surface.reset();
}
surface.draw( 0, 0 );
```
* create() - Recreates the surface.
* free() - Frees the surface.
* set() - Sets the surface as the current draw target.
* reset() - Pops the surface if it is the current draw target.
* draw( x, y ) - Draws the surface at x, y.
* update( force ) - Returns true if the surface should be redrawn, and will recreate the surface if it doesn't exist.
#### Timer( \*format, \*decimal_places )
The Timer is a simple way to get a formatted difference between two times in your program. If format and decimal_places are defined, they will override the default "$S" and 1 respectively.
* reset() - Resets the timer.
* elapsed() - Returns how much time has elapsed since the timer was last reset().
* toString() - Returns a StringTime formatted string with the time elapsed.
#### Vec2( x, y )
A simple garbage-collected, two-dimensional vector structure.
* set( x, y ) - Sets the x and y values of this vector.
* add( Vec2 ) - Adds Vec2 to this one.
* subtract( Vec2 ) - Subtracts Vec2 from this one.
* Multiply( Vec2 ) - Multplies this vectory by Vec2.
* Divide( Vec2 ) - Divides this vector by Vec2.
* dot( Vec2 ) - Returns the dot product of this vector and Vec2.
* toArray() - Returns this vector as an array.
* toString() - Returns this vector as an array as a string.
* [Database](#database)
* [File Handling](#file-handling)
* [Input Handling](#input-handling)
* [Logging](#logging)
* [Publisher](#publisher)
* [Render](#render)
* [Scripting](#scripting)
* [Misc Functions](#misc-functions)

### Shapes
Shape is an interface that is used to define shapes. This data type is used heavily by the Pointer feature for creating GUI interactions, but is provided as a generic data type to allow future extensions.
* inside( x, y ) - Returns if the point lies within this shape's dimensions.
* draw( x, y, outline ) - Draws the shape either solid, or outlined at x, y.
* set( x, y ) - Sets the position of the shape to x, y.
#### ShapeCircle( x, y, radius )
Defines a circle at x, y with the given radius. Implements the Shape interface.
#### ShapeEllipses( x, y, width, height )
Defines an elipses at x, y with the given width and height. Implements the Shape interface.
#### ShapePolygon( x1, y1... )
Defines a polygon with the given list of points, will provide the final closing pair. Implements the Shape interface.
#### ShapeRectangle( x, y, width, height )
Defines a rectangle at x, y with the given width and height. Implements the Shape interface.

### Data Structures
* [DsChain](#dschain)
* [DsLinkedList](#dslinkedlist-values-)
* [DsList](#dslist-values-)
* [DsTree](#dstree)
* [DsMap](#dsmap)
* [DsQueue](#dsqueue-values-)
* [DsStack](#dsstack-values-)
* [DsTable](#dstable)
#### DsChain
Provides a linked-list style interface to build garbage-collected data structures.
* clear() - Clears the data structure.
* empty() - Returns if the data structure is empty.
* size() - Returns the size of the data structure.
* toArray() - Returns the data structure as an array.
* toString() - Returns the data structure as an array as a string.
#### DsLinkedList( values... )
Provides a garbage-collected, linear-traversable data structure. Adds the values as provided. Implements DsChain.
* clear() - Clears all entries.
* empty() - Returns if the linked list is empty.
* size() - Returns the number of entries.
* add() - Adds a new entry to the end of the list.
* remove() - Removes the first matching entry.
* start() - Returns processing to the start of the list.
* first() - Returns the first entry.
* has_next() - Returns if there are further entries.
* next() - Returns the next entry. If the end has been reached, will return to, and return, the first entry.
* toArray() - Returns the entries in the linked list as an array.
* toString() - Returns the linked list as an array converted to a string.
#### DsList( values... )
Provides a wrapper for the built-in ds_list data structure. Adds the values as provided. Must be destroyed with destroy() to prevent memory leak.
* add( a... ) - Adds the given entries.
* insert( a, b ) - Inserts a at index b.
* remove_value( a ) - Seeks and deletes the first value that matches a.
* remove_index( a ) - Removes index a from the list, if it exists.
* size() - Returns the size of the list.
* empty() - Returns if the list is empty.
* sort( ascending ) - Sorts the list, in ascending order if true.
* swap( a, b ) - Swaps indexes a and b.
* find_value( a ) - Returns the index of the first value that matches a, or -1 if none.
* find_index( a ) - Returns the value found at index a, or undefined if it doesn't exist.
* destroy() - Destroys the internal ds_list.
* toString() - Returns the list as a comma-separated string.
#### DsTree
The DsTree is a walkable tree data structure with support for custom data types, symbolic links and branch copying. Must be destroyed with destroy() to prevent memory leak.
* seek( a ) - Returns the branch at a.
* lock( a ) - Sets a to be read-only.
* unlock( a ) - Sets a to be writable.
* size( branches ) - Returns the size of the branch, including sub-branches if branches is true.
* get( a, b ) - Returns the value at a, or b if it does not exist.
* set( a, b, c ) - Sets the value at a to b, if c is provided will enforce that data type.
* copy( a ) - Returns a copy of this branch, including sub-branches, or copies this branch, including sub-branches, to branch a if supplied.
* remove( a ) - Removes the branch at a.
* destroy() - Destroys this branch and all sub-branches, excluding symbolic links.
* toString() - Returns this branch as a string, used for debug purposes.
#### DsMap
Provides a wrapper for the built-in ds_map data structure. Must be destroyed with destroy() to prevent memory leak.
* add( a, b ) - Adds key a with value b, will not replace a if it already exists.
* replace( a, b ) - Replaces key a with value b, will create key a if it does not exist.
* remove( a ) - Removes key a if it exists.
* empty() - Returns if the map is empty.
* size() - Returns the number of entries in the map.
* find( a, b ) - Returns the value at key a if it exists, and undefined if it does not.  If b is provided, will return b if the key does not exist instead.
* first() - Returns the first entry in the map.
* next( a ) - Returns the next key after key a in the map.
* read( a ) - Reads a and converts it into entries in the map.
* toString() - Returns the map as a string which can be read with read()
#### DsQueue( values... )
Provides a garbage-collected queue, operates on a first-in-first-out basis. Enqueues the values as provided. Implements DsChain.
* enqueue( a... ) - Adds the entries into the queue in order given.
* enqueue_at_head() - Adds the entries into the head of the queue in the order given.
* dequeue() - Removes the entry at the head of the queue and returns it.
* head() - Returns the entry at the head of the queue.
* tail() - Returns the entry at the rear of the queue.
* clear() - Clears the queue.
* empty() - Returns if the queue is empty.
* size() - Returns the number of entries in the queue.
* toArray() - Returns the queue as an array.
* toString() - Returns the queue as an array as a string.
#### DsStack( values... )
Provides a garbage-collected stack, operates on a first-in-last-out basis. Pushes the values to the stack as provided. Implements DsChain.
* push( a... ) - Pushes the entries onto the stack in the order given.
* pop() - Removes the entry on the top of the stack and returns it.
* top() - Returns the entry on the top of the stack.
* clear() - Clears the stack.
* empty() - Returns if the stack is empty.
* size() - Returns the size of the stack.
* toArray() - Returns the stack as an array.
* toString() - Returns the stack as an array as a string.
#### DsTable
Provides a data structure that behaves as a map and a list. Must be destroyed with destroy() to prevent memory leak.
* add( a, b ) - Adds key a with value b to the table.
* empty() - Returns if the table is empty.
* size() - Returns the number of entries in the table.
* find_value_by_key( a, b ) - Returns the value at key a, or undefined. If b is provided, will instead return b if the key does not exist.
* find_value_by_index( a, b ) - Returns the value at index a, or undefined. If b is provided, will instead return b if the index does not exist.
* find_index_by_value( a ) - Returns the first index that contains value a, or -1 if it doesn't exist.
* replace_by_key( a, b ) - Replaces the value at key a with b. Key a will be created if it does not exist.
* replace_by_index( a, b ) - Replaces the value at index a with b, if it exists.
* first_key() - Returns the first key in the table.
* next_key( a ) - Returns the key following key a, or undefined if it does not exist.
* destroy() - Destroys the data structures in the table.
* toArray() - Returns the key value pairs as nested arrays.
* toString() - Retursn the table as key value pairs as nested arrays as a string.

## Database
The FAST database is a DsTree-based data loading system. It uses a lua-like language to write database files, and supports features such as overwriting, custom data types, inheritance, templating, and macros. It was designed for projects like RPGs that have large amounts of external data, but is also useful for implementing localization.
## Events
The FAST event system allows for quickly writing and calling custom events without having to rely on spawning objects. They can be set to have a delay, or discard themselves after running. The following event would be run once, thirty frames later, during the step event, and print Hello World! to the Output.
```GML
event = new EventOnce( FAST.STEP, 30, self, function() {
  show_debug_message( "Hello World!" );
});
```
## File Handling
The File interface is designed to open a file, read its contents into an internal data structure, and then close the file.  This allows for files read into the game to be manipulated more easily, and provides a consistent interface no matter what format the file that is being read from may be written in.
### File( filename, \*read_only )
```GML
var _file = new File( "filename" );

while ( _file.eof() == false ) {
  var _read = _file.read();
}
```
The File interface provides a common framework to seek, open, write to, and save files.
* reset() - Returns file progress to the start.
* exists( a ) - Returns if file a exists.
* read() - Returns the next readable piece of the file.
* peek( a ) - Returns the value at position a of the file, or undefined if it doesn't exist.
* poke( a, b ) - Writes b to position a of the file, if it exists.
* remaining() - Returns how much of the file is left to read.
* eof() - Returns if the end of the file has been reached.
* close() - Attempts to write this file to the disk, replacing the one originally read from. If read_only was true, this operation should always fail.
* discard() - Discards this file without writing any changes to the disk.
* clear() - Erases the contents of this file.
* toArray() - Returns this file as an array.
* toString() - Returns the name of the source file and lines read, used for debugging.
### FileText( filename, read_only )
Provides a file wrapper for reading from, and writing to, plain text files. Implements File.
## Input Handling
## Logging
FAST provides a general purpose logging system to handle outputs based on the current ERROR_LEVEL. Implements the Logger constructor which can write to anything that implements the GenericOutput interface.
### Logger( name, length, output... )
```GML
logger = new Logger( "Debug", 144, System, new FileText( "logs/debug.txt" ) );
```
The Logger constructor creates a new logging interface that pushes inputs into the given outputs. Additionally, it will attempt to close any those outputs when the program ends, ie: writing loose entries to files. Name is prepended to when the Logger is written to, for disinguishing between different outputs. Length will wrap the string at-or-near the given length. You may include as many outputs as desired, and anything that implements the GenericOutput interface will work. This includes System, which will write to the output, or FileText, which will write to an external file.
* write( string ) - Writes the string to the log.
* close() - Closes the log and removes it from the system.
* clear() - Clears the connected outputs.  Has no effect on System.
#### log_debug( id, event, value... )
When the ERROR_LEVEL is >= ERROR_DEBUG, will write the id (use undefined if called from a source that does not have an id), along with the event, and finally any additional text to System.
#### log_notify( id, event, value... )
When the ERROR_LEVEL is >= ERROR_NOTIFY, will write the id (use undefined if called from a source that does not have an id), along with the event, and finally any additional text to System.
#### log_nonfatal( id, event, value... )
When the ERROR_LEVEL is >= ERROR_NONFATAL, will write the id (use undefined if called from a source that does not have an id), along with the event, and finally any additional text to System and "log/nonfatal.txt"
#### log_critical( id, event, value... )
When the ERROR_LEVEL is >= ERROR_CRITICAL, will write the id (use undefined if called from a source that does not have an id), along with the event, and finally any additional text to System and "log/critical.txt"
## Publisher
The FAST publisher system allows subscribing to specific "events" and, when called, will pass messages to the subscribing objects for processing.
## Render
The FAST render offers a simple system for supporting a large number of resolutions by either using the built-in views, or custom requirements if needed.
## Scripting
The FAST scripting system utilizes Yarn-like external text files to write code which can be executed in game. Scripts can contain commands, but also support plain-text parsing for passing information into the game, or wait commands which will halt processing. Additionally, scripts can be written as functions which do not provide external parsing but can take arguments and return values the same as internal functions. Additionally, scripts can be written as functions which behave like internal functions and can have arguments or return values. Functions can not pause execution, but they can return values.
```GML
scriptEngine.run_script( "girlA" );

myDialogue = scriptEngine.next();
```
```
// girlA.txt
<< if spokeTo.girlA>>
Oh, hello again! I didn't expect to see you so soon.
<< else >>
Hello, my name is Shelly. Pleased to meet you!
<< end >>
```
## Misc Functions
Lastly, FAST includes general purpose functions to fill in some of the missing features in GML.
* [Arrays](#array-functions)
* [Draw](#draw-functions)
* [Include](#include-functions)
* [Integer](#integer-functions)
* [String](#string-functions)
### Array Functions
* array_concat( a... ) - Returns a concantated array build from the provided arrays.
* array_contains( a, b ) - Returns the index of array a that contains b, or -1 if it isn't found.
* array_difference( a, b... ) - Returns array a with b subtracted from it.
* array_unique( a ) - Returns an array containing the unique entries in a.
* array_union( a... ) - Returns an array containing all the unique entires of the provided arrays.
* array_sort( a, start, end, ascending, pivot, compare ) - See internal documentation, provides a general-purpose quicksort algorithm for sort-in-place operations on arrays.
* array_to_string( a, b ) - Returns the contents of array separated by b as a string.
### Draw Functions
* draw_bar( sprite, index, x, y, width, percent ) - Draws a bar using a 3-slice method using the sprite provided, and with width(in pixels) filled to percent(0 to 1).
* draw_text_bubble( sprite, index, x, y, width ) - Draws a "text bubble" using a 5-frame sprite with the given width(in pixels).
### Include Functions
* include( object ) - Runs the current event from object.
### Integer Functions
* integer_wrap( value, a, b ) - Returns value wrapped between a and b.
### String Functions
* string_con( a... ) - Returns a concantated string containing a...
* string_explode( a, b, trim ) - Returns an array of string broken up by b.  If trim is true, whitespace will be removed from each entry.
* string_explode_reverse( a, b, trim ) - Returns an array of string broken up by b in reverse order.  If trim is true, whitespace will be removed from each entry.
* string_find_first( chars, string, start ) - Returns the position of the first character in chars found in string, or 0 if none are found. If start is provided, the search will begin at the following character.
* string_justify( a, b, align, character ) - Returns a with white space added to confirm to a character width of b and an alignment of align (fa_left, fa_center, fa_right). If character is supplied, that will be used instead of " ".
* string_trim( a ) - Returns a with the preceeding and following whitespace removed.
* string_to_real( a ) - Converts a to a number, or 0 if it can not be converted.  Supports 0x hexadecimal and 0.0 formats.
