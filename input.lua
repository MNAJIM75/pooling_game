local input = {}

input.is_pressed = rl.IsKeyPressed
input.is_mouse_down = rl.IsMouseButtonDown
input.is_mouse_pressed = rl.IsMouseButtonPressed
input.is_mouse_released = rl.IsMouseButtonReleased

input.key_l = rl.KEY_L
input.key_p = rl.KEY_P
input.key_a = rl.KEY_A
input.left_mouse_button = rl.MOUSE_BUTTON_LEFT
input.mouse_left_button = input.left_mouse_button
input.mouse_right_button = rl.MOUSE_BUTTON_RIGHT
input.right_mouse_button = input.mouse_right_button
input.mouse_middle_button = rl.MOUSE_BUTTON_MIDDLE
input.middle_mouse_button = input.mouse_middle_button

function input.get_mouse_position()
	local mx, my = rl.GetMouseX(), rl.GetMouseY()
	return mx, my
end
return input
