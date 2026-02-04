local ca, cb, world, play_ball

local function handle_movement()
  local velocity = vector.new(0, 0)
  local speed = 100
  if IsKeyDown(KEY_W) then velocity.y = -speed
  elseif IsKeyDown(KEY_S) then velocity.y = speed
  else velocity.y = 0
  end
  if IsKeyDown(KEY_D) then velocity.x = speed
  elseif IsKeyDown(KEY_A) then velocity.x = -speed
  else velocity.x = 0
  end
  return velocity
end

local function apply_movement(b, velocity, dt)
  b.position.x = b.position.x + velocity.x * dt 
  b.position.y = b.position.y + velocity.y * dt
end

function game_init()
	ca = phy.new_circle(20, 20)
	cb = phy.new_circle(25, 25)
	phy.init()
	world = phy.new_world()
	for i=1, 9 do
	  world:add_body(phy.new_circle(i*20, i*20))
	end
	play_ball = world.bodies[1]
end

function game_update(dt)
  if input.is_pressed(input.key_l) then
    log.info("Force applied.")
    play_ball:add_impulse(-1000, 1)
  end
  if input.is_pressed(input.key_p) then
    log.info(play_ball.acceleration)
    log.info(play_ball.velocity)
  end
  world:update(dt)
end

function game_draw()
  world:draw()
  for i=1, 9 do
    local b = world.bodies[i]
    local x, y = b.position.x, b.position.y
    rl.DrawCircle(x, y, 10, graphics.red)
  end
end

function game_close()
	phy.close()
end
