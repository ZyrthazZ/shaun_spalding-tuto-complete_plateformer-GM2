// Check if the left arrow key is being pressed
var _key_left = keyboard_check(vk_left) || keyboard_check(ord("Q"));

// Check if the right arrow key is being pressed
var _key_right = keyboard_check(vk_right) || keyboard_check(ord("D"));

// Check if the spacebar (jump) key has been pressed
var _key_jump = keyboard_check_pressed(vk_space);

// Calculate movement direction: -1 for left, 1 for right, 0 for no movement
var _move = _key_right - _key_left;

// Check if the player is on the ground
var _on_ground = place_meeting(x, y + 1, oWall);

// Set horizontal speed based on movement direction and walking speed
horizontal_sp = _move * walk_sp;

// Apply gravity to vertical speed
vertical_sp += grv;

// Jump
if (_on_ground && _key_jump) {
    vertical_sp = -7;
}

// Horizontal Collision
if (place_meeting(x + horizontal_sp, y, oWall)) {
    // While there is no collision, move the player one step closer to the wall
    while (!place_meeting(x + sign(horizontal_sp), y, oWall)) {
        x += sign(horizontal_sp);
    }
    // Stop horizontal movement on collision
    horizontal_sp = 0;
}

// Update the player's x position based on horizontal speed
x += horizontal_sp;

// Vertical Collision
if (place_meeting(x, y + vertical_sp, oWall)) {
    // While there is no collision, move the player one step closer to the wall
    while (!place_meeting(x, y + sign(vertical_sp), oWall)) {
        y += sign(vertical_sp);
    }
    // Stop vertical movement on collision
    vertical_sp = 0;
}

// Update the player's y position based on vertical speed
y += vertical_sp;

// Animations
if (!place_meeting(x, y + 1, oWall)) {
    // Set the sprite to the jumping/falling animation
    sprite_index = sPlayerA;
    image_speed = 0; // Stop the sprite animation

    // Set the image index based on whether the player is jumping or falling
    if (sign(vertical_sp) > 0) {
        image_index = 1; // Falling frame
    } else {
        image_index = 0; // Jumping frame
    }
} else {
    // Player is on the ground
    image_speed = 1; // Resume the sprite animation

    if (_move == 0) {
        // Player is idle
        sprite_index = sPlayer; // Idle sprite
    } else {
        // Player is moving
        sprite_index = sPlayerR; // Running sprite
    }
}

if(horizontal_sp != 0){
	image_xscale = sign(horizontal_sp);
}