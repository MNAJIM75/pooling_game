__DEBUG = true
__RAYLIB_BARF = nil
if arg[3] and arg[3] == 'false' then __RAYLIB_BARF = false end
if arg[3] and arg[3] == 'true' then __RAYLIB_BARF = true end

local game_file = arg[2] or "game"
if game_file == "tests." then game_file = "game_mainmenu" end

system = require'system'
log = require'log'
graphics = require'graphics'
vector = require'vector'
phy = require'phy'
input = require'input'
require'love'
camera = require'camera'
require("loader")
gui = require'gui'
require(game_file)

log.info("Program Starts") -- Program starts
system.init()
loader.init()
graphics.init(graphics.width, graphics.height, graphics.title)
game_init()
while not graphics.should() do
  local dt = graphics.get_dt()
  game_update(dt)
  if input.is_pressed(input.key_a) then
    system.change_game('tests.mouse_game')
  end
  graphics.begin_drawing()
  graphics.clear(graphics.black)
  game_draw()
  graphics.end_drawing()
end
game_close()
graphics.close()
system.close()
log.info("Program Ends") -- Program ends
