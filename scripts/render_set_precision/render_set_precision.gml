/// @func render_set_precision
/// @param {float}	precision	A float, 0.1 <= precision <= 1.0
/// @desc	Sets the pixel precision that can be used when scaling the rendered screen. 1.0 means
///		the final scale must be pixel perfect, while 0.5 would allow for duplication of up to half
///		a scene's pixels.
function render_set_precision( _precision ) {
	RenderManager.set_precision( _precision );
	
}
