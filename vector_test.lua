__DEBUG = true
setmetatable(_G, {__index = rl})
local vector = require'vector'
local phy = require'phy'

local ca = phy.new_circle(20, 20)
local cb = phy.new_circle(25, 25)
local world = phy.new_world()
for i=1, 9 do
  world:add_body(phy.new_circle(i*20, i*20))
end


function handle_movement()
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

function apply_movement(b, velocity, dt)
  b.position.x = b.position.x + velocity.x * dt 
  b.position.y = b.position.y + velocity.y * dt
end

InitWindow(800, 600, "phy")
phy.init()
while not WindowShouldClose() do
  local dt = GetFrameTime()
  world.bodies[1].velocity = handle_movement()
  -- apply_movement(world.bodies[1], velocity, GetFrameTime())
  world:update(dt)
  BeginDrawing()
  ClearBackground(BLACK)
  world:draw()
  for i=1, 9 do
    local b = world.bodies[i]
    local x, y = b.position.x, b.position.y
    DrawCircle(x, y, 10, RED)
  end
  EndDrawing()
end
CloseWindow()

