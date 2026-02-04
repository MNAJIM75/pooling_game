local menu
local canvas

local function start_game_callback()
    system.change_game('game')
end

function game_init()
    gui:init()
    canvas = gui.new_canvas()
    canvas:add_element(gui.new_interactive_bg())
    menu = gui.new_menu(0, 0, "Billiardo")
    menu:add_button("start game", start_game_callback)
    menu:add_button("options")
    menu:add_button("quit game")
    canvas:add_element(menu)
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
