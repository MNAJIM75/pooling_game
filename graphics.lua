local graphics = {}

graphics.width = 1280
graphics.height = 720
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

graphics.white = rl.WHITE
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

graphics.draw_text = rl.DrawText
graphics.draw_line = rl.DrawLine

return graphics

