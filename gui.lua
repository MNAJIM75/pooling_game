local gui = {}
local center_width
local center_height

function gui:init()
    self.normal_state = 0
    self.hover_state = 1
    self.clicked_state = 2
    
    self.camera = camera()
    self.camera:follow(0,0)
    
    -- TODO: use another functions for loading and unloading fonts
    self.font_label = rl.LoadFontEx("./res/fonts/Couple Together.otf", 32*4, nil, 0)
    rl.SetTextureFilter(self.font_label.texture, rl.TEXTURE_FILTER_POINT)
    assert(self.font_label.baseSize >= 0, "[Gui] failed to load font.")

    self.font_ui = rl.LoadFontEx("./res/fonts/open-sans/OpenSans-Bold.ttf", 32*4, nil, 0)
    rl.SetTextureFilter(self.font_ui.texture, rl.TEXTURE_FILTER_POINT)
    assert(self.font_ui.baseSize >= 0, "[Gui] failed to load font.")

    self.btn_texture = loader.load_texture("C:/dev/gitrepos/pooling_game/res/gui/PNG/SLIDERS SELECTORS/clean ui_selector-15.png")
    rl.SetTextureFilter(self.btn_texture, rl.TEXTURE_FILTER_POINT)

    center_width = graphics.width / 2
    center_height = graphics.height / 2
    log.info("[Gui] initialized.")
end

function gui.new_canvas()
    local c = {}
    c.type = 'Canvas'
    c.elements = {}
    function c:update(dt)
        for i, v in pairs(self.elements) do
            v:update(dt)
        end
        gui.camera:update(dt)
    end

    function c:add_element(_el)
        table.insert(self.elements, _el)
    end

    function c:draw()
        -- graphics.push()
        -- graphics.translate(center_width, center_height)
        gui.camera:attach()
        for i, v in pairs(self.elements) do
            v:draw()
        end
        gui.camera:detach()
        -- graphics.pop()
    end
    return c
end

function gui.new_element(x, y)
    local e = {}
    e.position = vector.new(_x, _y)
    e.type = 'Ui Element'
    function e:update(dt) end
    function e:draw() end
    return e
end


function gui.new_label(_x, _y, _content, _size, _color, _spacing, _angle, _font)
    local l = gui.new_element(_x, _y)
    l.type = "Label"
    l.content = _content or ""
    l.font = _font or "font_label"
    l.size = _size or 32*4
    l.color = _color or graphics.white
    l.spacing = _spacing or 1
    l.angle = _angle or 0
    l.measure_v = graphics.measure_text(gui[l.font], l.content, l.size, l.spacing)
    l.origin = vector.new(l.measure_v.x/2, l.measure_v.y/2)
    function l:draw()
        graphics.draw_font(
            gui[self.font],
            self.content,
            self.position,
            self.origin, self.angle,
            self.size, self.spacing,
            self.color
        )
    end
    return l
end

function gui.new_button(_x, _y, )
    local b = gui.new_element(_x, _y)
    b.type = "Button"

    -- gui style
    b.label = gui.new_label(_x, _y, "Start Game", 48, nil, nil, nil, 'font_ui')
    b.rect = {x=0, y=0, width=gui.btn_texture.width, height=gui.btn_texture.height}
    b.dest = {x=b.position.x, y=b.position.y, width=gui.btn_texture.width, height=gui.btn_texture.height}
    b.correction = 0
    b.origin = vector.new(b.rect.width/2, (b.rect.height/2)+b.correction)
    b.angle = 0
    b.color = graphics.white
    b.collision_box = {x=b.dest.x-b.origin.x, y=b.dest.y-b.origin.y, width=b.dest.width, height=b.dest.height}

    b.state = gui.normal_state

    function b:update(dt)
        if self.state == gui.normal_state then
            local mx, my = input.get_mouse_position()
            mx, my = gui.camera:toWorldCoords(mx, my)
            -- TODO: Change this checking function
            if rl.CheckCollisionPointRec(vector.new(mx, my), self.collision_box) then
                self.color = graphics.red
            else self.color = graphics.white
            end
        end
    end
    
    function b:draw()
        graphics.draw_texture_pro(
            gui.btn_texture,
            self.rect, self.dest,
            self.origin, self.angle,
            self.color
        )
        self.label:draw()
    end
    return b
end

function gui:close()
    rl.UnloadFont(self.font_label)
    rl.UnloadFont(self.font_ui)
    loader.unload_texture(self.btn_texture)
    log.info("[Gui] closed.")
end

return gui
