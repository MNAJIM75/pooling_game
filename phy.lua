local vector = require"vector"
local phy = {}
local radi = 10
local mass = 10
local masses = mass * 2
local sqr_radi = 4 * radi * radi
local drag = 0.993
local boundery_width = 100
local boundery_height = 200
local friction_coff = 0.2 -- 0.15 - 0.4
local restitution = 0.2
local gravity = 9.81
local boundery = {
  top = 0,
  left = 0,
}
boundery.right = boundery.left + boundery_width
boundery.down = boundery.top + boundery_height

local function clamp(_v, _min, _max)
  return math.max(_min, math.min(_v, _max))
end

function phy.init(_width, _height)
  local screen_width, screen_height = graphics.width, graphics.height
  boundery_width = _width or screen_width
  boundery_height = _height or screen_height

  -- centering arena
  boundery.left = (screen_width - boundery_width) / 3
  boundery.top = (screen_height - boundery_height) / 3
  
  boundery.right = boundery.left + boundery_width
  boundery.down = boundery.top + boundery_height
  log.trace("[Phy] initialized.")
end

function phy.detect_collision(_ba, _bb)
  if _ba.type == _bb.type then 
    local sqr_dist = vector.sqr_dist(_ba.position, _bb.position)
    return sqr_radi > math.abs(sqr_dist)
  else return phy.rect_circle_coll(_ba, _bb)
  end
end

function phy.rect_circle_coll(_rect, _circ)
  if "rect" ~= _rect.type then
    local t_rect = _circ
    _circ = _rect
    _rect = t_rect
  end
  local cx, cy = _circ.position.x, _circ.position.y
  local rx, ry, rw, rh = _rect.position.x, _rect.position.y, _rect.width, _rect.height

  local closest_x = clamp(cx, rx, rx+rw)
  local closest_y = clamp(cy, ry, ry+rh)
  -- graphics.draw_line(cx, cy, closest_x, closest_y, graphics.yellow)

  -- distance between circle center and closest point
  local distance_2 = (cx - closest_x)^2 + (cy - closest_y)^2
  return distance_2 <= radi * radi
end

function phy.rebounce(b)
  if b.static then return end
  local l, t, r, d = b.position.x - radi, b.position.y - radi, b.position.x + radi, b.position.y + radi
  if l < boundery.left or r > boundery.right then b.velocity.x = b.velocity.x * -1 end
  if t < boundery.top or d > boundery.down then b.velocity.y = b.velocity.y * -1 end
end

function phy.rect_circle_resolve(_rect, _circ)
  if "rect" ~= _rect.type then
    local t_rect = _circ
    _circ = _rect
    _rect = t_rect
  end
  local cx, cy = _circ.position.x, _circ.position.y
  local vx, vy = _circ.velocity.x, _circ.velocity.y
  local rx, ry, rw, rh = _rect.position.x, _rect.position.y, _rect.width, _rect.height

  local closest_x = clamp(cx, rx, rx+rw)
  local closest_y = clamp(cy, ry, ry+rh)
  local dx = cx - closest_x
  local dy = cy - closest_y
  local distance_2 = dx^2 + dy^2
  distance_2 = math.sqrt(distance_2)
  if distance_2 < radi then
    -- static resolving
    local penetration = radi - distance_2
    local nx, ny = dx/distance_2, dy/distance_2
    cx = cx + nx * penetration
    cy = cy + ny * penetration

    -- dynamic resolving
    local dot = vx*nx + vy*ny
    vx = vx - (1+restitution) * dot * nx
    vy = vy - (1+restitution) * dot * ny

    _circ.position.x = cx
    _circ.position.y = cy
    _circ.velocity.x = vx
    _circ.velocity.y = vy
  end
end
-- def resolve_collision(cx, cy, r, vx, vy, rx, ry, w, h, restitution=1.0):
--     # Find closest point
--     closestX = max(rx, min(cx, rx + w))
--     closestY = max(ry, min(cy, ry + h))

--     dx = cx - closestX
--     dy = cy - closestY
--     dist = (dx*dx + dy*dy) ** 0.5

--     if dist < r:  # collision detected
--         # --- Static resolution ---
--         penetration = r - dist
--         nx, ny = dx/dist, dy/dist  # normal
--         cx += nx * penetration
--         cy += ny * penetration

--         # --- Dynamic resolution ---
--         dot = vx*nx + vy*ny
--         vx -= (1 + restitution) * dot * nx
--         vy -= (1 + restitution) * dot * ny

--     return cx, cy, vx, vy

function phy.resolve_collision(_ba, _bb)
  if _ba.type ~= _bb.type then
    phy.rect_circle_resolve(_ba, _bb)
  else
    local ba_position = _ba.position
    local bax, bay = ba_position.x, ba_position.y
    local bb_position = _bb.position
    local bbx, bby = bb_position.x, bb_position.y
    local distance = vector.distance(ba_position, bb_position)
    local overlap = distance - (radi * 2)
    -- if either is static overlap should multiply by .  
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
end


-- Function to check point-circle collision
function phy.point_circle_col(px, py, cx, cy, radius)
    -- Calculate distance between point and circle center
    local dx = px - cx
    local dy = py - cy
    local distanceSquared = dx * dx + dy * dy
    
    -- Compare squared distance with squared radius
    return distanceSquared <= radius * radius
end



function phy.new_world()
  local world = {}

  -- variables
  world.bodies = {}
  
  
  -- functions
  function world.get_boundery(side)
    return boundery[side]
  end

  function world:get_body_at(x, y)
    for i, b in pairs(self.bodies) do
      local bx, by = b.position.x, b.position.y
      if phy.point_circle_col(x, y, bx, by, radi) then
        return b
      end
    end
    return nil
  end
  
  function world:update(dt)
    local bodies_count = #self.bodies
    -- update
    for i=bodies_count, 1, -1 do
      local b = self.bodies[i]
      b:update(dt)
      phy.rebounce(b)
    end

    -- collision loop
    for i = 1, bodies_count - 1 do
      local ba = self.bodies[i]
      for j = i + 1, bodies_count do
        local bb = self.bodies[j]
        if phy.detect_collision(ba, bb) then
          log.info("collision " ..ba.type.." / "..bb.type)
          phy.resolve_collision(ba, bb)
        end
      end
     end  
  end

  function world:draw()
    if __DEBUG then
      graphics.rect_line(boundery.left, boundery.top, boundery.right, boundery.down, graphics.white)
    end
  end
  
  function world:add_body(_body)
    table.insert(self.bodies, _body)
    log.info("[Phy.World] body added seccefully.")
  end
  
  function world:remove_body(_body)
    assert(false, "Gundam ya ami")
  end
  log.info("[Phy.World] created.")
  return world
end

function phy.new_rect(_x, _y, _w, _h)
  local rect = {}
  -- variables
  rect.type = "rect"
  rect.static = true
  rect.position = vector.new(_x, _y)
  rect.width = _w
  rect.height = _h
  function rect:draw()
    if __DEBUG then
      local x, y, w, h = self.position.x, self.position.y, self.width, self.height
      graphics.rect_line(x, y, w, h, graphics.green)
    end
  end
  function rect:update(dt) end
  return rect
end

function phy.new_circle(_x, _y)
  local circle = {}

  -- variables
  circle.type = "circle"
  circle.position = vector.new(_x, _y)
  circle.velocity = vector.new()
  circle.acceleration = vector.new()

  -- functions
  function circle:update(dt)
    if vector.sqr_length(self.velocity) > 0 then
      local ax, ay = self.acceleration.x, self.acceleration.y
      local px, py = self.position.x, self.position.y
      local vx, vy = self.velocity.x, self.velocity.y

      vx = vx + ax * dt
      vy = vy + ay * dt
      px = px + vx * dt
      py = py + vy * dt

      self.velocity.x = vx
      self.velocity.y = vy
      self.position.x = px
      self.position.y = py
      -- self.acceleration.x = 0
      -- self.acceleration.y = 0
      -- vx = vx * drag
      -- vy = vy * drag
      -- self.velocity.x = vx
      -- self.velocity.y = vy
      self:friction()
    end
  end
  
  function circle:draw()
    local x, y = self.position.x, self.position.y
    graphics.circ_line(x, y, radi, graphics.green)
  end

  function circle:add_force(_force_r, _angle)
    local fx = _force_r * math.cos(_angle)
    local fy = _force_r * math.sin(_angle)
    local ax, ay = fx / mass, fy / mass
    self.acceleration.x = ax
    self.acceleration.y = ay
  end  

  function circle:add_impulse(_force_r, _angle)
    -- F = mv2 - mv1
    -- *mv1 initial which is zero
    -- F = mv2
    -- F is vector
    -- fx = mvx -> Fcos(a) = m* vcos(a)
    -- fy = mvy -> Fsin(a) = m* vsin(a)
    local fx = _force_r * math.cos(_angle)
    local fy = _force_r * math.sin(_angle)
    local vx = fx/mass
    local vy = fy/mass
    self.velocity.x = vx
    self.velocity.y = vy
  end

  function circle:friction()
    local v_norm = vector.norm(self.velocity)
    local fx = -friction_coff*gravity* v_norm.x
    local fy = -friction_coff*gravity* v_norm.y
    self.acceleration.x = fx
    self.acceleration.y = fy
  end
  
  return circle
end

function phy.close()
  log.trace("[Phy] closed.")
end

return phy
