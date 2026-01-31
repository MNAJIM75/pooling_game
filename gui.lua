local gui = {}
local center_width
local center_height

function gui:init()
    self.font_label = rl.LoadFontEx("./res/fonts/Couple Together.otf", 32*4, nil, 0)
    rl.SetTextureFilter(self.font_label.texture, rl.TEXTURE_FILTER_POINT)
    assert(self.font_label.baseSize >= 0, "[Gui] failed to load font.")

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
    end

    function c:add_element(_el)
        table.insert(self.elements, _el)
    end

    function c:draw()
        graphics.push()
        graphics.translate(center_width, center_height)
        for i, v in pairs(self.elements) do
            v:draw()
        end
        graphics.pop()
    end
    return c
end

function gui.new_element(x, y)
    local e = {}
    e.position = vector.new(_x, _y)
    function e:update(dt) end
    function e:draw() end
    return e
end

function gui.new_lebel(_x, _y, _content)
    local l = gui.new_element(_x, _y)
    l.content = _content
    l.size = 32*4
    l.color = graphics.white
    l.spacing = 1
    local measure_v = graphics.measure_text(gui.font_label, l.content, l.size, l.spacing)
    l.origin = vector.new(measure_v.x/2, measure_v.y/2)
    function l:draw()
        graphics.draw_font(
            gui.font_label,
            self.content,
            self.position,
            self.origin, 0,
            self.size, self.spacing,
            self.color
        )
    end
    return l
end

function gui:close()
    rl.UnloadFont(self.font_label)
    log.info("[Gui] closed.")
end

return gui
