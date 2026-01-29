local mouse = {}

function mouse:init()
  self.ox = nil
  self.oy = nil
  self.cx = nil
  self.cy = nil
  self.down = false
  log.trace("[Mouse] initialized.")
end

function mouse:update(dt)
  self.down = input.is_mouse_down(input.left_mouse_button) 
  if input.is_mouse_pressed(input.left_mouse_button) then
    mouse.ox, mouse.oy = input.get_mouse_position()
  end
  if self.down then
    mouse.cx, mouse.cy = input.get_mouse_position()
  end
end

function mouse:draw()
  if self.down then
    graphics.draw_line(mouse.ox, mouse.oy, mouse.cx, mouse.cy, graphics.red)
  end
end

function mouse:get_body_at()

end

function mouse:close()
  log.trace("[Mouse] closed.")
end

return mouse 
