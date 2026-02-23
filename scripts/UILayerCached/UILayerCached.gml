function UILayerCached( _x, _y, _width, _height, _callback = undefined ) : UILayer( _x, _y, _width, _height, _callback ) constructor {
	static superDraw	= static_get( UILayer ).draw;
	static draw	= function( _x = 0, _y = 0 ) {
		if ( surface.needsUpdate( redraw )) {
			surface.clear( color, alpha );
			superDraw( -x, -y );
			redraw	= false;
			
		}
		surface.draw( _x + x, _y + y );
		
	}
	static drawPart	= function( _x = 0, _y = 0, _l = 0, _t = 0, _w = width, _h = height ) {
		if ( surface.needsUpdate( redraw )) {
			surface.clear( color, alpha );
			superDraw( 0, 0 );
			redraw	= false;
			
		}
		surface.drawPart( _x + x, _y + y, _l, _t, _w, _h );
		
	}
	static style	= function( _color = color, _alpha = alpha ) {
		color	= _color;
		alpha	= _alpha;
		return self;
		
	}
	static destroy	= function() {
		surface.destroy();
		
	}
	width	= _width;
	height	= _height;
	surface	= new Surface( width, height );
	redraw	= false;
	color	= c_white;
	alpha	= 0.0;
	
}
