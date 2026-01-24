setmetatable(_G, {__index=rl})

local soldier_t = require'soldier_t'

local window_width, window_height, window_title = 800, 600, "Shader Posiion"


local soldier = soldier_t.new()
print(soldier)

InitWindow(window_width, window_height, window_title)
while not WindowShouldClose() do
  local dt = GetFrameTime()
  soldier:update(dt)
  BeginDrawing()
  ClearBackground(BLACK)
  soldier:draw()
  EndDrawing()
end
CloseWindow()
