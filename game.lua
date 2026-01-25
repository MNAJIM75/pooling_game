local world
local bg_sprite
local bg_x, bg_y

local play_ball
function game_init()
  phy.init(254*3, 3*128)
  loader.init()
  world = phy.new_world()
  bg_sprite = sprites[13]
  bg_x, bg_y = world.get_boundery('left'), world.get_boundery('top')
  log.trace("[Game] initialized.")
end

function game_update(dt)
  world:update(dt)
  -- if input.is_pressed(rl.KEY_A) then
  --   bg_x = bg_x - 1
  -- elseif input.is_pressed(rl.KEY_W) then
  --   bg_y = bg_y - 1
  -- end
end

function game_draw()
  world:draw()
  graphics.draw_sprite(
    bg_sprite,
    bg_x, bg_y,
    graphics.white
  )
  graphics.draw_text(tostring(bg_x), 0, 40, 12, graphics.green)
  graphics.draw_text(tostring(bg_y), 0, 60, 12, graphics.green)
end

function game_close()
  loader.close()
  phy.close()
  log.trace("[Game] closed.")
end
