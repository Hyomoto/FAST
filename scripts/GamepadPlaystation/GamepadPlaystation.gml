/// @func GamepadPlaystation
/// @desc provides a Gamepad interface that reflects the playstation controller layout
function GamepadPlaystation() : Gamepad() constructor {
	left	= new input( gp_padl, self );
	right	= new input( gp_padr, self );
	up		= new input( gp_padu, self );
	down	= new input( gp_padd, self );
	
	x		= new input( gp_face1, self );
	circle	= new input( gp_face2, self );
	square	= new input( gp_face3, self );
	triangle= new input( gp_face4, self );
	
	r1		= new input( gp_shoulderr, self );
	l1		= new input( gp_shoulderl, self );
	lclick	= new input( gp_stickr, self );
	rclick	= new input( gp_stickl, self );
	share	= new input( gp_select, self );
	option	= new input( gp_start, self );
	
	r2		= new input( gp_shoulderrb, self );
	l2		= new input( gp_shoulderlb, self );
	
	lstick	= new inputAxis( gp_axislh, gp_axislv, self );
	rstick	= new inputAxis( gp_axisrh, gp_axisrv, self );
	
}
