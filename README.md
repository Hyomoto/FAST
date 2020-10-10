# FAST v3.3
Flexible Assistant Toolkit for Gamemaker Studio 2 - GML is a simple language with many built-in features that make it accessible to new and advanced users. However, many tasks are unexpectedly tricky, such as file or resolution handling, and don't quite match up with how straightforward GMS can be. FAST is a lightweight library that provides easy-to-use tools that allow developers to focus on building their game. It begins with a lightweight "Core" module and uses only a single object to power universal mouse, keyboard and gamepad support, custom event handling, saving/loading files, and more! For advanced developers or those seeking to get just the right fit from FAST, standard interfaces exist for everything: implementing and extending Core features ensures anyone can quickly write extensions with confidence their systems will work seamlessly. The library does not contain genre-specific code or implementation.  Instead, FAST focuses on general utility and adaptability. It has powerful tools such as databases for loading and saving complex data and even a Lua-like scripting language. These tools provide general utility to the language rather than box it in. In short, FAST can complement any and every game made with GMS2.3 or later.

Check the Wiki for the most up-to-date documentation on each module.




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

### Draw Functions
* draw_bar( sprite, index, x, y, width, percent ) - Draws a bar using a 3-slice method using the sprite provided, and with width(in pixels) filled to percent(0 to 1).
* draw_text_bubble( sprite, index, x, y, width ) - Draws a "text bubble" using a 5-frame sprite with the given width(in pixels).
