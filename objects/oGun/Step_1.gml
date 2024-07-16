//Set the position of the oGun relatively to the player position
x= oPlayer.x;
y = oPlayer.y + 10;

//Sets the oGun image angle towards the mouse orientation
image_angle = point_direction(x, y, mouse_x, mouse_y); 

firingdelay = firingdelay - 1

if(mouse_check_button(mb_left) && firingdelay < 0) {
	firingdelay = 5;
	
	with (instance_create_layer(x, y, "Bullets", oBullet)) {
		speed = 25;
		direction = other.image_angle;
		image_angle = direction;
	}
}