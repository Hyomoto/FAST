function Viewport( _view, _x, _y, _width, _height, _cameraWidth = undefined, _cameraHeight = undefined ) constructor {
	view			= _view;
	view_enabled	= true;
	view_set_visible( _view, true );
	
	view_set_xport( _view, _x );
	view_set_yport( _view, _y );
	view_set_wport( _view, _width );
	view_set_hport( _view, _height );
	
	camera			= new Camera( _view, _cameraWidth ?? _width, _cameraHeight ?? _height );
	
}
