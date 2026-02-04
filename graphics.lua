local graphics = {}

graphics.width = 1366
graphics.height = 768
graphics.title = "Poolling"

graphics.init = function(_w, _h)
  graphics.width = _w or graphics.width
  graphics.height = _h or graphics.height
  rl.InitWindow(graphics.width, graphics.height, graphics.title)
  log.trace("[Graphics] initialized.")
end

graphics.close = function ()
  rl.CloseWindow()
  log.trace("[Graphics] closed.")
end

graphics.should = rl.WindowShouldClose
graphics.begin_drawing = rl.BeginDrawing
graphics.end_drawing = rl.EndDrawing
graphics.clear = rl.ClearBackground
graphics.rect_line = rl.DrawRectangleLines
graphics.circ_line = rl.DrawCircleLines
graphics.get_dt = rl.GetFrameTime
graphics.measure_text = rl.MeasureTextEx
graphics.draw_font = rl.DrawTextPro

graphics.white = rl.WHITE
graphics.raywhite = rl.RAYWHITE
graphics.black = rl.BLACK
graphics.red = rl.RED
graphics.green = rl.GREEN
graphics.orange = rl.ORANGE
graphics.yellow = rl.YELLOW
graphics.gray = rl.GRAY
graphics.brown = rl.BROWN

function graphics.draw_sprite(sp, x, y, tint)
  rl.DrawTexture(sp, x, y, tint)
end

function graphics.sharp_filter(_tex)
        rl.SetTextureFilter(_tex, rl.TEXTURE_FILTER_POINT)
end

-- void DrawTexturePro(Texture2D texture, Rectangle source, Rectangle dest, Vector2 origin, float rotation, Color tint);
graphics.draw_texture_pro = rl.DrawTexturePro

graphics.draw_text = rl.DrawText
graphics.draw_line = rl.DrawLine
graphics.draw_rect = rl.DrawRectangle

-- matrix functions
function graphics.push() rl.rlPushMatrix() end
function graphics.pop() rl.rlPopMatrix() end
function graphics.translate(_x, _y) rl.rlTranslatef(_x, _y, 0.0) end
function graphics.rotate(_a) rl.rlRotatef(_a, 0, 0, 1) end
function graphics.scalef(_s) rl.rlScalef(_s, _s, 1) end
function graphics.identity() rl.rlLoadIdentity() end

return graphics

