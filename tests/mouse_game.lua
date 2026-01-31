local mouse
function game_init()
	mouse = require'mouse'
	mouse:init()
end

function game_update(dt)
	mouse:update(dt)
end

function game_draw()
	mouse:draw()
end

function game_close()
	mouse:close()
end
