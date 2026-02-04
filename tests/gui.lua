local canvas
function game_init()
    -- gui = require'gui'
    gui:init()
    canvas = gui.new_canvas()
    -- canvas:add_element(gui.new_label(200,200, "Gundam Entertaiment"))
    -- local menu = gui.new_menu(0, 0, "Main Menu")
    -- menu:add_button("Start Game")
    -- menu:add_button("Options")
    -- menu:add_button("Quit Game")
    -- canvas:add_element(menu)
    canvas:add_element(gui.new_interactive_bg())
    canvas:add_element(gui.new_message("Please wait for connection..."))
    
    -- canvas:add_element(gui.new_button(90, 90))
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
