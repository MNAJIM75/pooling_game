local world
local bg_sprite
local bg_dest, bg_rect, bg_origin

local play_ball
function game_init()
  loader.load_game_textures()
  bg_sprite = sprites[13]
  phy.init(bg_sprite.width, bg_sprite.height)
  world = phy.new_world()
  local bg_x, bg_y = world.get_boundery('left'), world.get_boundery('top')
  local bg_width, bg_height = world.get_boundery('right') - bg_x, world.get_boundery('down') - bg_y
  bg_dest = {x=bg_x, y=bg_y, width=bg_width, height=bg_height}
  bg_rect = {x=0, y=0, width=bg_sprite.width, height=bg_sprite.height}
  log.trace("[Game] initialized.")
  bg_origin = vector.new(0, 0)
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
  graphics.draw_texture_pro(
    bg_sprite, bg_rect, bg_dest,
    bg_origin, 0, graphics.white
  )
  graphics.draw_text(tostring(bg_x), 0, 40, 12, graphics.green)
  graphics.draw_text(tostring(bg_y), 0, 60, 12, graphics.green)
end

function game_close()
  loader.close()
  phy.close()
  log.trace("[Game] closed.")
end
