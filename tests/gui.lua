local gui
local canvas
function game_init()
    gui = require'gui'
    gui:init()
    canvas = gui.new_canvas()
    canvas:add_element(gui.new_label(0, 0, "Gundam Entertaiment"))
    canvas:add_element(gui.new_button())
end

function game_update(dt)
    canvas:update(dt)
end

function game_draw()
    canvas:draw()
end

function game_close()
    gui:close()
end
