local world

function game_init()
  phy.init(254*3, 3*128)
  loader.init()
  world = phy.new_world()
  log.trace("[Game] initialized.")
end

function game_update(dt)
  world:update(dt)
end

function game_draw()
  world:draw()
end

function game_close()
  loader.close()
  phy.close()
  log.trace("[Game] closed.")
end
