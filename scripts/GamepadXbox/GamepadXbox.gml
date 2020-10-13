/// @func GamepadXbox
/// @desc provides a Gamepad interface that reflects the xbox controller layout
/// @wiki Input-Handling-Index
function GamepadXbox() : Gamepad() constructor {
	left	= new input( gp_padl, self );
	right	= new input( gp_padr, self );
	up		= new input( gp_padu, self );
	down	= new input( gp_padd, self );
	
	a		= new input( gp_face1, self );
	b		= new input( gp_face2, self );
	x		= new input( gp_face3, self );
	y		= new input( gp_face4, self );
	
	rb		= new input( gp_shoulderr, self );
	lb		= new input( gp_shoulderl, self );
	lclick	= new input( gp_stickr, self );
	rclick	= new input( gp_stickl, self );
	back	= new input( gp_select, self );
	menu	= new input( gp_start, self );
	
	rt		= new input( gp_shoulderrb, self );
	lt		= new input( gp_shoulderlb, self );
	
	lstick	= new inputAxis( gp_axislh, gp_axislv, self );
	rstick	= new inputAxis( gp_axisrh, gp_axisrv, self );
	
}
