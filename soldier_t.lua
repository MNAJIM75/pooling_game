local soldier = {}

local speed = 100
function soldier.new()
  local self = {}
  setmetatable(self, {__index=soldier})
  self.position = {x=0, y=0}
  self.velocity = {x=0, y=0}
  self.acceleration= {x=0, y=0}
  return self
end

function soldier.update(self, dt)
  self:handle_movement()
  self.position.x = self.position.x + self.velocity.x * dt 
  self.position.y = self.position.y + self.velocity.y * dt
end

function soldier:handle_movement()
  if IsKeyDown(KEY_W) then self.velocity.y = -speed
  elseif IsKeyDown(KEY_S) then self.velocity.y = speed
  else self.velocity.y = 0
  end
  if IsKeyDown(KEY_D) then self.velocity.x = speed
  elseif IsKeyDown(KEY_A) then self.velocity.x = -speed
  else self.velocity.x = 0
  end
  
end

function soldier.draw(self)
  DrawCircle(self.position.x, self.position.y, 20, RED)
end

return soldier
