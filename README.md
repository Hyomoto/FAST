# FAST v3.3
Flexible Assistant Toolkit for Gamemaker Studio 2 - GML is a simple language with many built-in features that make it accessible to new and advanced users. However, many tasks are unexpectedly tricky, such as file or resolution handling, and don't quite match up with how straightforward GMS can be. FAST is a lightweight library that provides easy-to-use tools that allow developers to focus on building their game. It begins with a lightweight "Core" module and uses only a single object to power universal mouse, keyboard and gamepad support, custom event handling, saving/loading files, and more! For advanced developers or those seeking to get just the right fit from FAST, standard interfaces exist for everything: implementing and extending Core features ensures anyone can quickly write extensions with confidence their systems will work seamlessly. The library does not contain genre-specific code or implementation.  Instead, FAST focuses on general utility and adaptability. It has powerful tools such as databases for loading and saving complex data and even a Lua-like scripting language. These tools provide general utility to the language rather than box it in. In short, FAST can complement any and every game made with GMS2.3 or later.

Check the Wiki for the most up-to-date documentation on each module.



# Database
The FAST database is a DsTree-based data loading system. It uses a lua-like language to write database files, and supports features such as overwriting, custom data types, inheritance, templating, and macros. It was designed for projects like RPGs that have large amounts of external data, but is also useful for implementing localization.
# Other Stuff
* [Database](#database)
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


## Input Handling

## Publisher
The FAST publisher system allows subscribing to specific "events" and, when called, will pass messages to the subscribing objects for processing.
## Render
The FAST render offers a simple system for supporting a large number of resolutions by either using the built-in views, or custom requirements if needed.
## Scripting
The FAST scripting system utilizes external text files to write code which can be executed in game. Scripts can contain commands and logical operations, but also support plain-text parsing for passing information into the game, and wait commands which will halt script processing. Additionally, scripts can be written as functions which behave more like internal functions, and support passing arguments by name.
### ScriptEngine( name, \*filepath, \*debug )
```GML
var _engine = new ScriptEngine( "Battle", "scripts/battle", true ).inherit();
```
The ScriptEngine constructor creates a new engine for executing scripts. While GML does not support parallel execution, you can make as many engines as you need without them interfering with one another. That said, scripts are decently fast but will serve as a source of performance drain on lower-end hardware. While each engine does not take up significant processing power on it's own, running many scripts per frame can. If a filepath is provided, the ScriptEngine will load all files it finds in the given directory/sub-directories. When debug is active, additional safety protocols are used to prevent scripts from crashing the program. This comes at a cost to performance, thus it is possible to turn debugging off to save performance once scripts have been debugged properly. The filepath and debug arguments are optional, and will default to undefined and false if not provided.
* inherit() - Will inherit global functions from ScriptManager(), returns self so it can be called alongside new if desired.
* execute_string( a ) - Converts a to a script expression which is then executed and the result returned.
* execute( a, args... ) - Will run script a with the given arguments. If a is a function, these arguments will be provided as named arguments, otherwise they will be pushed to the variable stack.
* load( a, reload ) - Loads a as a script.  If a is a directory, will load all files in the directory/sub-directories. If reload is true, scripts will be overwritten.
* load_async( a, reload, period ) - The same as load() except loads files asynchronously. Period specifies how long to load scripts before returning execution.
* log( event, strings... ) - Writes to the ScriptEngine logger. Formats as engine name \[event\] strings...
* get_value( a ) - Returns the value of key a.
* set_value( a, b ) - Sets value of key a to b.
* get_queue() - Returns the DsQueue used by this ScriptEngine for storing parse strings.
* set_queue() - Sets the DsQueue used by this ScriptEngine for storing parse strings.
* proceed() - Continues processing if ScriptEngine is waiting. Can override any wait, but must be used to continue a generic "wait" command.
* is_running() - Returns true if the ScriptEngine is processing scripts.
* is_waiting() - Returns true if the ScriptEngine is currently waiting.
#### Writing Scripts
FAST Scripts use a human-readable syntax that consists of 11 reserved keywords. Each line can contain only one keyword and expression, and there are two formats for writing scripts: parse scripts and function scripts. While they both support the same features, they use a slightly different syntax. Function scripts are purely logical and are defined using the function() header:
```
function( x, y )
return x + y
```
This would define a function script that takes the arguments x and y, and then returns their sum. Parse scripts are used to return strings that can then be operated on, and have a special syntax.  Any arguments passed to a parse script will be pushed to the variable stack and can be retrieved with pop(). Lastly logical blocks/statements *must* be encapsulated with << and >>, anything outside of these will be treated as a parse string. This format is primarily designed for features where logical operations are helpful, but return values must be operated on. For example, we could use a script to decide what dialogue an NPC will use:
```
<< if spoke_with_NPC == false >>
Hello, have we met before?
<< else >>
Hello again, how are you?
<< end >>
```
##### Keywords
* if/elseif/else/end - Used to create logical blocks. Every if block *must* have a corresponding end.
```
if x == 0
else if x == 1
else
end
```
* set/set local - Used to set values. These values are set on the ScriptEngine and can be retrieved using get_value(), local variables can also be created by following set with local.
```
set hit_points to 10
set local tries to 4
```
* return - Ends script processing. If an expression is provided, will return that as well.
```return 10 * 2```
* push/pop - Pushes and pops values to/from the variable stack. Variables provided to a parse function must be retrieved this way.
```
set local target to pop()

push( target.name )
```
* wait/wait until - Causes script execution to halt, and resume once the wait condition completes. Using wait by itself will perform a general wait which can only be cleared by calling proceed() on the ScriptEngine. Calling wait with an expression will wait the given number of frames. Lastly, wait until will continue once the expression returns true.
```
wait
wait 30
wait until target.x == 0
```
### Draw Functions
* draw_bar( sprite, index, x, y, width, percent ) - Draws a bar using a 3-slice method using the sprite provided, and with width(in pixels) filled to percent(0 to 1).
* draw_text_bubble( sprite, index, x, y, width ) - Draws a "text bubble" using a 5-frame sprite with the given width(in pixels).
