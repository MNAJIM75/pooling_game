local gui = {}
local center_width
local center_height

function gui:init()
    self.normal_state = 1
    self.hover_state = 2
    self.clicked_state = 3
    
    self.camera = camera()
    self.camera:follow(0,0)
    
    -- TODO: use another functions for loading and unloading fonts
    self.font_label = rl.LoadFontEx("./res/fonts/Couple Together.otf", 32*4, nil, 0)
    rl.SetTextureFilter(self.font_label.texture, rl.TEXTURE_FILTER_POINT)
    assert(self.font_label.baseSize >= 0, "[Gui] failed to load font.")

    self.font_ui = rl.LoadFontEx("./res/fonts/open-sans/OpenSans-Bold.ttf", 32*4, nil, 0)
    rl.SetTextureFilter(self.font_ui.texture, rl.TEXTURE_FILTER_POINT)
    assert(self.font_ui.baseSize >= 0, "[Gui] failed to load font.")

    self.btn_texture = {}
    self.btn_texture[self.normal_state] = loader.load_texture("C:/dev/gitrepos/pooling_game/res/gui/PNG/SLIDERS SELECTORS/clean ui_selector-16.png")
    self.btn_texture[self.hover_state] = loader.load_texture("C:/dev/gitrepos/pooling_game/res/gui/PNG/SLIDERS SELECTORS/clean ui_selector-15.png")
    self.btn_texture[self.clicked_state] = loader.load_texture("C:/dev/gitrepos/pooling_game/res/gui/PNG/SLIDERS SELECTORS/clean ui_selector-14.png")
    print(self.btn_texture[1].width)
    for i=self.normal_state, self.clicked_state do
        graphics.sharp_filter(self.btn_texture[i])
    end

    self.menu_texture = loader.load_texture("C:/dev/gitrepos/pooling_game/res/gui/PNG/CLEAN MENUS/clean ui_clean menu-01.png")
    graphics.sharp_filter(self.menu_texture)

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

function gui.new_element(_x,_y)
    local e = {}
    e.position = vector.new(_x, _y)
    e.type = 'Ui Element'
    e.enable = true
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

function gui.new_button(_x, _y, _content)
    local b = gui.new_element(_x, _y)
    b.type = "Button"

    -- gui style
    b.label = gui.new_label(_x, _y, _content, 46, nil, nil, nil, 'font_ui')
    b.correction = 0
    b.rect, b.dest, b.origin, b.collision_box = {}, {}, {}, {}
    for i=gui.normal_state, gui.clicked_state do
        b.rect[i] = {x=0, y=0, width=gui.btn_texture[i].width, height=gui.btn_texture[i].height}
        b.dest[i] = {x=b.position.x, y=b.position.y, width=gui.btn_texture[i].width, height=gui.btn_texture[i].height}
        b.origin[i] = vector.new(b.rect[i].width/2, (b.rect[i].height/2)+b.correction)
        b.collision_box[i] = {x=b.dest[i].x-b.origin[i].x, y=b.dest[i].y-b.origin[i].y, width=b.dest[i].width, height=b.dest[i].height}
    end
    b.angle = 0
    b.color = graphics.white

    b.state = gui.normal_state

    function b:update(dt)
        if self.enable then
            local mx, my = input.get_mouse_position()
            local cmx, cmy = gui.camera:toWorldCoords(mx, my)
            local vc = vector.new(cmx, cmy)
            local collision = rl.CheckCollisionPointRec(vc, self.collision_box[self.state])
            self.state = collision and gui.hover_state or gui.normal_state
            if input.is_mouse_down(input.left_mouse_button) and self.state == gui.hover_state then
                self.state = gui.clicked_state
            end
            if self.state == gui.hover_state and input.is_mouse_released(input.left_mouse_button) then
                if self.on_click then self.on_click() else log.warn("[Gui Button] no cilck function!.") end
            end
        end
    end
    
    function b:draw()
        if not self.enable then return end
        -- if self.state == gui.hover_state then self.color = graphics.white
        -- elseif self.state == gui.clicked_state then self.color = graphics.red
        -- else self.color = graphics.green end
        graphics.draw_texture_pro(
            gui.btn_texture[self.state],
            self.rect[self.state], self.dest[self.state],
            self.origin[self.state], self.angle,
            self.color
        )
        self.label:draw()
    end
    return b
end

function gui.new_rect(_x, _y, _w, _h) return {
    x = _x, y = _y, width = _w, height = _h
} end

function gui.new_menu(_x, _y, _content)
    local m = gui.new_element(_x, _y)
    m.type = "Menu"
    m.b_width, m.b_height = gui.menu_texture.width+1, gui.menu_texture.height+1
    m.headline = gui.new_label(_x, _y-m.b_height/3, _content, 58)
    m.rect = gui.new_rect(0, 0, m.b_width, m.b_height)
    m.dest = gui.new_rect(_x, _y, m.rect.width, m.rect.height)
    m.origin = vector.new(m.dest.width/2, m.dest.height/2)
    
    m.y_start = -90
    m.y_padding = 74
    m.btn_list = {}
    function m:add_button(_btn_string, _on_click)
        assert(_btn_string and type(_btn_string) == "string", "[Gui Menu] Wrong type type added to the menu.")
        local btn = gui.new_button(self.position.x, self.position.y+self.y_start+(#self.btn_list*self.y_padding), _btn_string)
        table.insert(self.btn_list, btn)
    end

    function m:remove_button(_btn_string)
        assert(_btn_string and type(_btn_string) == "string", "[Gui Menu] Wrong type type to be removed from the menu.")
        -- TODO:
        assert(false, "Not Implemented yet!.")
    end

    function m:draw_buttons()
        for i,v in pairs(self.btn_list) do
            v:draw()
        end
    end

    function m:update_buttons(dt)
        for i,v in pairs(self.btn_list) do
            v:update(dt)
        end
    end

    function m:update(dt)
        self:update_buttons(dt)
    end
    
        -- local x = m.dest.x
        -- local y = m.dest.y
        -- local width = m.dest.width
        -- local height = m.dest.height - m.dest.height / 3
    function m:draw()
        if not self.enable then return end
        graphics.draw_texture_pro(
            gui.menu_texture,
            self.rect, self.dest, self.origin, 0,
            graphics.white
        )
        self.headline:draw()
        self:draw_buttons()
        if input.is_pressed(input.key_l) then y = y - 1; height = height - 1 end
        if input.is_pressed(input.key_p) then y = y + 1; height = height + 1 end
    end
    return m
end

function gui:close()
    rl.UnloadFont(self.font_label)
    rl.UnloadFont(self.font_ui)
    loader.unload_texture(self.btn_texture[gui.normal_state])
    loader.unload_texture(self.btn_texture[gui.hover_state])
    loader.unload_texture(self.btn_texture[gui.clicked_state])
    log.info("[Gui] closed.")
end

return gui
