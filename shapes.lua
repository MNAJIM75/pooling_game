local vector = require'vector'
local shapes = {}

local texShapes = rl.new("Texture2D",1, 1, 1, 1, 7) -- Texture used on shapes drawing (white pixel loaded by rlgl)
local texShapesRec = rl.new("Rectangle", 0.0, 0.0, 1.0, 1.0) -- Texture source rectangle used on shapes drawing
local angle = 0

function shapes.vec2(_x, _y) return rl.new("Vector2", _x , _y) end
-- function shapes.draw_trapezoid(_x1, _y1, _x2, _y2, color)
--     local v_start = vector.new(_x1,_y1)
--     local v_end = vector.new(_x2, _y2)
--     local length, angle = vector.distance(v_start, v_end)
--     -- local r = length / 6
--     local r = 100
 
--     -- triangle 2 first to calculate mouse pos
--     local v1 = rl.new("Vector2", 0, 0) -- shapes.vec2(_x2, _y2)
--     local v2 = rl.new("Vector2", 0, 0+r) -- shapes.vec2(_x2-r, _y2-r)
--     local v3 = rl.new("Vector2", 0+r, 0+r) -- shapes.vec2(_x2+r, _y2-r)
--     -- DrawCircleV(v1, 10, BLUE)
--     angle = angle + GetFrameTime()
--     if angle >= 3.14 then angle = angle - 3.14 end 
    
--     rlSetTexture(texShapes.id);
--     local shapeRect = texShapesRec;

--     rlBegin(RL_QUADS);
--         rlNormal3f(0,0,0);
--         rlColor4ub(color.r, color.g, color.b, color.a);

--         rlRotatef(angle, 1, 1, 0)
--         rlTexCoord2f(shapeRect.x/texShapes.width, shapeRect.y/texShapes.height);
--         rlVertex2f(v1.x, v1.y);

--         rlTexCoord2f(shapeRect.x/texShapes.width, (shapeRect.y + shapeRect.height)/texShapes.height);
--         rlVertex2f(v2.x, v2.y);

--         rlTexCoord2f((shapeRect.x + shapeRect.width)/texShapes.width, (shapeRect.y + shapeRect.height)/texShapes.height);
--         rlVertex2f(v3.x, v3.y);

--         rlTexCoord2f((shapeRect.x + shapeRect.width)/texShapes.width, shapeRect.y/texShapes.height);
--         rlVertex2f(v3.x+r, v3.y);
--         -- rlVertex2f(_x2, _y2)
--         rlRotatef(0, 1, 1 ,1)
--     rlEnd();

--     rlSetTexture(0);
-- end
function shapes.draw_trapezoid(xo1, yo1, xo2, yo2, color)
    local x0, y0 = xo1, yo1
    local dx, dy = xo2- xo1, yo2 - yo1
    local length = math.sqrt(dx*dx+dy*dy)
    local theta = math.atan2(dy, dx)
    local cos_th = math.cos(theta)
    local sin_th = math.sin(theta)
    local third = length - length/3

    -- calculating normal
    local side_length = math.min(110, third/3)
    local r = 120 - side_length
    local x1 = xo1 + third * cos_th
    local y1 = yo1 + third * sin_th
    local alpha = -math.pi/2  + theta
    local cos_a = math.cos(alpha)
    local sin_a = math.sin(alpha)
    local x1p = r * cos_a
    local y1p = r * sin_a
    local xf1 = x1 + x1p
    local yf1 = y1 + y1p
    rl.DrawLine(x1, y1, xf1, yf1, rl.RED)

    local xf2 = x1 - x1p
    local yf2 = y1 - y1p
    rl.DrawLine(x1, y1, xf2, yf2, rl.RED)

    local v1 = vector.new(xo1, yo1)
    local v2 = vector.new(xf1, yf1)
    local v3 = vector.new(xf2, yf2)
    local v4 = vector.new(xo2, yo2)

    rl.DrawTriangle(v1, v3, v2, rl.RED)
    rl.DrawTriangle(v2, v3, v4, rl.YELLOW)

    rl.DrawCircleV(v1, 10, rl.ORANGE)
    rl.DrawCircleV(v2, 10, rl.ORANGE)
    rl.DrawCircleV(v3, 10, rl.ORANGE)
    rl.DrawCircleV(v4, 10, rl.ORANGE)

    rl.DrawText("V2", v2.x, v2.y, 12, rl.WHITE)
    rl.DrawText("V3", v3.x, v3.y, 12, rl.WHITE)
    rl.DrawText("V4", v4.x, v4.y, 12, rl.WHITE)

    
    -- original line
    rl.DrawLine(xo1, yo1, xo2, yo2, color)
end

return shapes
