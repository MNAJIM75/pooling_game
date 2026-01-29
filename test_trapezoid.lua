setmetatable(_G, {__index=rl})

InitWindow(800, 600, "Trapezoid")
local shapes = require'shapes'
print(DrawTriangle)
while not WindowShouldClose() do
    BeginDrawing()
    ClearBackground(BLACK)
    shapes.draw_trapezoid(400, 300, GetMouseX(), GetMouseY(), GREEN)
    EndDrawing()
end

CloseWindow()
