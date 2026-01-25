__DEBUG = true
log = require'log'
graphics = require'graphics'
vector = require'vector'
phy = require'phy'
dofile("loader.lua")
dofile("game.lua")

log.info("Program Starts") -- Program starts
graphics.init(graphics.width, graphics.height, graphics.title)
game_init()
while not graphics.should() do
  local dt = graphics.get_dt()
  game_update(dt)
  graphics.begin_drawing()
  graphics.clear(graphics.black)
  game_draw()
  graphics.end_drawing()
end
game_close()
graphics.close()
log.info("Program Ends") -- Program ends
