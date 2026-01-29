local vector = require'vector'
local shapes = {}

local texShapes = rl.new("Texture2D",1, 1, 1, 1, 7) -- Texture used on shapes drawing (white pixel loaded by rlgl)
local texShapesRec = rl.new("Rectangle", 0.0, 0.0, 1.0, 1.0) -- Texture source rectangle used on shapes drawing
local angle = 0

function shapes.vec2(_x, _y) return rl.new("Vector2", _x , _y) end
function shapes.draw_trapezoid(_x1, _y1, _x2, _y2, color)
    local v_start = vector.new(_x1,_y1)
    local v_end = vector.new(_x2, _y2)
    local length, angle = vector.distance(v_start, v_end)
    -- local r = length / 6
    local r = 100
 
    -- triangle 2 first to calculate mouse pos
    local v1 = rl.new("Vector2", 0, 0) -- shapes.vec2(_x2, _y2)
    local v2 = rl.new("Vector2", 0, 0+r) -- shapes.vec2(_x2-r, _y2-r)
    local v3 = rl.new("Vector2", 0+r, 0+r) -- shapes.vec2(_x2+r, _y2-r)
    -- DrawCircleV(v1, 10, BLUE)
    angle = angle + GetFrameTime()
    if angle >= 3.14 then angle = angle - 3.14 end 
    
    rlSetTexture(texShapes.id);
    local shapeRect = texShapesRec;

    rlBegin(RL_QUADS);
        rlNormal3f(0,0,0);
        rlColor4ub(color.r, color.g, color.b, color.a);

        rlRotatef(angle, 1, 1, 0)
        rlTexCoord2f(shapeRect.x/texShapes.width, shapeRect.y/texShapes.height);
        rlVertex2f(v1.x, v1.y);

        rlTexCoord2f(shapeRect.x/texShapes.width, (shapeRect.y + shapeRect.height)/texShapes.height);
        rlVertex2f(v2.x, v2.y);

        rlTexCoord2f((shapeRect.x + shapeRect.width)/texShapes.width, (shapeRect.y + shapeRect.height)/texShapes.height);
        rlVertex2f(v3.x, v3.y);

        rlTexCoord2f((shapeRect.x + shapeRect.width)/texShapes.width, shapeRect.y/texShapes.height);
        rlVertex2f(v3.x+r, v3.y);
        -- rlVertex2f(_x2, _y2)
        rlRotatef(0, 1, 1 ,1)
    rlEnd();

    rlSetTexture(0);
end

return shapes
