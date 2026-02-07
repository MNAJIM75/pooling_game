local ffi = require'ffi'
local svglib
local texture
function game_init()
	ffi.cdef([[
		Image LoadImageSVG(const char *fileName, int width, int height);	
	]])
	svglib = ffi.load("svglib.dll")
	local image = svglib.LoadImageSVG("res/svg/ui_clean.svg", graphics.width, graphics.height)
    local err = ffi.errno()
    print("open failed, errno:", err)

	texture = rl.LoadTextureFromImage(image)
	rl.UnloadImage(image)
	graphics.clear_color = graphics.white
end

function game_update(dt)

end

function game_draw()
	rl.DrawTexture(texture, 0, 0, graphics.white)
end

function game_close()
	rl.UnloadTexture(texture)
end
