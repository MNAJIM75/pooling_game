local mouse = {}

mouse.ox = nil
mouse.oy = nil
mouse.cx = nil
mouse.cy = nil
mouse.down = false

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

return mouse 
