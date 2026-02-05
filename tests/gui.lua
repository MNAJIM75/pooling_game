local canvas
local cam
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
    cam = rl.new("Camera2D")
    cam.target = vector.new(0, 0)
    -- cam.offset = vector.new(graphics.width/2, graphics.height/2)
    cam.zoom = 1
end

function game_update(dt)
    cam.zoom = cam.zoom + rl.GetMouseWheelMove()
    if input.is_mouse_down(input.left_mouse_button) then
        local mouse = rl.GetMouseDelta()
        cam.target.x = cam.target.x - mouse.x / cam.zoom
        cam.target.y = cam.target.y - mouse.y / cam.zoom
    end
    canvas:update(dt)
end

function game_draw()
    rl.BeginMode2D(cam)
    canvas:draw()
    rl.EndMode2D()
end

function game_close()
    gui:close()
end
