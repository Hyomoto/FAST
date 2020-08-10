/// @func ShapePolygon
/// @param x0
/// @param y0
function ShapePolygon() : Shape() constructor {
	static get_point	= function( _int ) {
		return new Vec2( x[ _int ], y[ _int ] );
		
	}
	static inside	= function( x0, y0 ) { // original by Xot, optimized by Hyomoto
	    var x1, y1, x2, y2;
		var inside	= false;
	    
	    var i = 0; repeat ( points ) {
	        x1 = xp[i];
	        y1 = yp[i];
			++i;
			
	        x2 = xp[i];
	        y2 = yp[i];
			
	        if ((y2 > y0) != (y1 > y0)) {
	            inside ^= (x0 < (x1-x2) * (y0-y2) / (y1-y2) + x2);
				
	        }
			
	    }
	    return inside;
		
	}
	static draw	= function( _x, _y, _outline ) {
		_x	= ( _x == undefined ? 0 : _x );
		_y	= ( _y == undefined ? 0 : _y );
		
		draw_primitive_begin( pr_linestrip );
		    var i = 0; repeat ( points + 1 ) {
				draw_vertex( _x + xp[ i ], _y + yp[ i ] );
				
		    }
			
		draw_primitive_end();
		
	}
	var _next	= 0;
	
	points	= argument_count div 2;
	xp		= array_create( points + 1 );
	yp		= array_create( points + 1 );
	
	var _i = 0; repeat( points ) {
		xp[ _next ]	= argument[ _i ]
		yp[ _next ]	= argument[ _i + 1 ];
		
		_next	+= 1;
		_i		+= 2;
		
	}
	xp[ _next ]	= xp[ 0 ];
	yp[ _next ]	= yp[ 0 ];
	
	x	= xp[ 0 ];
	y	= yp[ 0 ];
	
}
