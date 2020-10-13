|Jump To|[`Go Back`](https://github.com/Hyomoto/FASTv33/wiki/Data-Types-Index)|[Arguments](#arguments)|[Methods](#methods)|[Variables](#variables)|
|---|---|---|---|---|
>## Vec2( x, y )
A simple, garbage-collected two-dimensional vector.
```GML
var _vec2 = new Vec2( 32, 20 );
```
## Arguments
|Name|Type|Purpose|
|---|---|---|
|`x`|real|The x position in this vector|
|`y`|real|The y position in this vector|
## Methods
|Jump To|[`top`](#)|[set](#set-x-y-)|[add](#add-vec2-)|[subtract](#subtract-vec2-)|[multiply](#multiply-vec2-)|[divide](#divide-vec2-)|[dot](#dot-vec2-)|[toArray](#toarray)|[toString](#tostring)|[is](#is-datatype-)|
|---|---|---|---|---|---|---|---|---|---|---|
> ### set( x, y )
*Returns:* N/A (`undefined`)
|Name|Type|Purpose|
|---|---|---|
|`x`|real|The x position to set this vector|
|`y`|real|The y position to set this vector|

Used to set both the x and y coordinates in this vector with a single method.
***
> ### add( Vec2 )
*Returns:* Vec2
|Name|Type|Purpose|
|---|---|---|
|`Vec2`|Vec2|The vector to add to this one.|

Used to sum two Vec2's together.
***
> ### subtract( Vec2 )
*Returns:* Vec2
|Name|Type|Purpose|
|---|---|---|
|`Vec2`|Vec2|The vector to subtract from this one.|

Used to find the difference between two Vec2's.
***
> ### multiply( Vec2 )
*Returns:* Vec2
|Name|Type|Purpose|
|---|---|---|
|`Vec2`|Vec2|The vector to multiply this one with.|

Used to multiply two Vec2's together.
***
> ### divide( Vec2 )
*Returns:* Vec2
|Name|Type|Purpose|
|---|---|---|
|`Vec2`|Vec2|The vector to divide this one by.|

Used to divide two Vec2's.
***
> ### dot( Vec2 )
*Returns:* real (`0.00`)
|Name|Type|Purpose|
|---|---|---|
|`Vec2`|Vec2|The vector to get the dot product with.|

Used to retrieve the dot product two Vec2's together.
***
> ### toArray()
*Returns:* array(`[ x, y ]`)
|Name|Type|Purpose|
|---|---|---|
|None|||

Returns this vector as an array.
***
> ### toString()
*Returns:* string("x, y")
|Name|Type|Purpose|
|---|---|---|
|None|||

Returns this vector as a comma-separated string value pair.
***
> ### is( datatype )
*Returns:* string("x, y")
|Name|Type|Purpose|
|---|---|---|
|`type`|struct id|The structure type to compare this against.|

Returns `true` if the provided type is Timer.
***
## Variables
|Jump To|[`top`](#)|
|---|---|

* x - the x position of this vector
* y - the y position of this vector

