__DEBUG = true

local game_file = arg[2] or "game"

system = require'system'
log = require'log'
graphics = require'graphics'
vector = require'vector'
phy = require'phy'
input = require'input'
require("loader")
require(game_file)

log.info("Program Starts") -- Program starts
system.init()
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
system.close()
log.info("Program Ends") -- Program ends
