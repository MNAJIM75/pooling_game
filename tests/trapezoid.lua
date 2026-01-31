local shapes
local ox, oy, mx, my
function game_init()
	shapes = require'shapes'
end

function game_update(dt)
	if input.is_mouse_pressed(input.left_mouse_button) then
		ox, oy = input.get_mouse_position()
	end
end

function game_draw()
	if input.is_mouse_pressed(input.left_mouse_button) then
		mx, my = input.get_mouse_position()
		shapes.darw_trapezoid(ox, oy, mx, my, graphics.green)
	end
end

function game_close()

end
