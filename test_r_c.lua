__DEBUG = true
setmetatable(_G, {__index=rl})

graphics = require'graphics'
phy = require'phy'
log = require'log'
input = require'input'

graphics.title = "Rectangle Circle Collision"
graphics.init(1366, 768)

phy.init()
world = phy.new_world()
local rec = phy.new_rect(300, 400, 500, 200)
local ball = phy.new_circle(100, 100)
world:add_body(rec)
world:add_body(ball)
while not graphics.should() do
	local dt = graphics.get_dt()
	if input.is_pressed(input.key_l) then ball:add_impulse(10000, 1) end
	world:update(dt)
	graphics.begin_drawing()
	graphics.clear(graphics.black)
	world:draw()
	rec:draw()
	ball:draw()
	graphics.end_drawing()
end

phy.close()

graphics.close()

