if ( keyframe != undefined )
	keyframe.update( useDeltaTime ? delta_time : 1 );
else if ( follow != noone && instance_exists( follow ))
	camera.setPosition( follow.x, follow.y );
if ( xprevious != x || yprevious != y )
	camera.setPosition( x, y );
if ( angle != camera.angle )
	camera.setAngle( angle );
if ( zoom != camera.scale )
	camera.setScale( zoom );
if ( offsetH != camera.offsetH || offsetV != camera.offsetV ) {
	camera.offsetH	= offsetH;
	camera.offsetV	= offsetV;
	camera.setPosition( camera.rawX, camera.rawY );
	
}
x	= camera.x;
y	= camera.y;
