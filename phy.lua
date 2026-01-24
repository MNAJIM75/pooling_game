local vector = require"vector"
local phy = {}
local radi = 10
local mass = 10
local masses = mass * 2
local sqr_radi = 4 * radi * radi
local drag = 0.993

function phy.detect_collision(_ba, _bb)
  local sqr_dist = vector.sqr_dist(_ba.position, _bb.position)
  return sqr_radi > math.abs(sqr_dist)
end

function phy.resolve_collision(_ba, _bb)
  local ba_position = _ba.position
  local bax, bay = ba_position.x, ba_position.y
  local bb_position = _bb.position
  local bbx, bby = bb_position.x, bb_position.y
  local distance = vector.distance(ba_position, bb_position)
  local overlap = distance - (radi * 2)
  -- if either is static overlap should multiply by .5
  
  local unitx = (bax-bbx) / distance
  local unity = (bay-bby) / distance

  -- apply static resolving
 ba_position.x = bax - overlap * unitx
 ba_position.y = bay - overlap * unity

 bb_position.x = bbx + overlap * unitx
 bb_position.y = bby + overlap * unity

 -- reset local vars
 bax, bay = ba_position.x, ba_position.y
 bbx, bby = bb_position.x, bb_position.y
 local a_velocity = _ba.velocity
 local b_velocity = _bb.velocity
 local avx, avy = _ba.velocity.x, _ba.velocity.y
 local bvx, bvy = _bb.velocity.x, _bb.velocity.y

 local nx, ny = (bbx-bax) / distance, (bby-bay) / distance
 local tx, ty = ny, -nx

 -- tangent calculation
 local dtana = avx * tx + avy * ty
 local dtanb = bvx * tx + bvy * ty

 -- normal calculation
 local dnormala = avx * nx + avy * ny
 local dnormalb = bvx * nx + bvy * ny

 -- conservation of momentum in 1D
 local ma = (dnormala * (0)+2 * mass * dnormalb) / masses
 local mb = (dnormalb * (0)+2 * mass * dnormala) / masses

 -- apply dynamic resloving
 a_velocity.x = dtana * tx + nx * ma
 a_velocity.y = dtana * ty + ny * ma

 b_velocity.x = dtanb * tx + nx * mb
 b_velocity.y = dtanb * ty + ny * mb
 
end

function phy.new_world()
  local world = {}

  -- variables
  world.bodies = {}
  
  
  -- functions
  function world:update(dt)
    local bodies_count = #self.bodies
    -- update
    for i=bodies_count, 1, -1 do
      local b = self.bodies[i]
      b:update(dt)
    end

    -- collision loop
    for i = 1, bodies_count - 1 do
      for j = i + 1, bodies_count do
        local ba = self.bodies[i]
        local bb = self.bodies[j]
        if phy.detect_collision(ba, bb) then
          phy.resolve_collision(ba, bb)
        end
      end
     end  
  end

  function world:draw()

  end
  
  function world:add_body(_body)
    table.insert(self.bodies, _body)
  end
  
  function world:remove_body(_body)
    assert(false, "Gundam ya ami")
  end
  return world
end

function phy.new_circle(_x, _y)
  local circle = {}

  -- variables
  circle.position = vector.new(_x, _y)
  circle.velocity = vector.new()
  circle.acceleration = vector.new()

  -- functions
  function circle:update(dt)
    if vector.sqr_length(self.velocity) > 0 then
      local px, py = self.position.x, self.position.y
      local vx, vy = self.velocity.x, self.velocity.y
      px = px + vx * dt
      py = py + vy * dt
      self.position.x = px
      self.position.y = py
      -- vx = vx * drag
      -- vy = vy * drag
      -- self.velocity.x = vx
      -- self.velocity.y = vy
    end
  end
  
  function circle:draw()

  end
  return circle
end


return phy
