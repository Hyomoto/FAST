function XinputGamepad( _id = 0, _threshold = 0.1 ) : Gamepad( _id ) {
    lstick  = new GamepadDualAxis( self, gp_axislh, gp_axislv, _threshold );
    lclick	= new GamepadButton( self, gp_stickl );
    
    rstick  = new GamepadDualAxis( self, gp_axisrh, gp_axisrv, _threshold );
	rclick	= new GamepadButton( self, gp_stickr );
    
	left	= new GamepadButton( self, gp_padl );
	right	= new GamepadButton( self, gp_padr );
	up		= new GamepadButton( self, gp_padu );
	down	= new GamepadButton( self, gp_padd );
	
	a		= new GamepadButton( self, gp_face1 );
	b		= new GamepadButton( self, gp_face2 );
	x		= new GamepadButton( self, gp_face3 );
	y		= new GamepadButton( self, gp_face4 );
	
	back	= new GamepadButton( self, gp_select );
	menu	= new GamepadButton( self, gp_start );
	
	lb		= new GamepadButton( self, gp_shoulderl );
	rb		= new GamepadButton( self, gp_shoulderr );
    
    lt      = new GamepadPressureInput( self, gp_shoulderlb );
    rt      = new GamepadPressureInput( self, gp_shoulderrb );
	
    static update = function() {
        lstick.update();
        rstick.update();
        lt.update();
        rt.update();
        
        return self;
        
    }
    
}