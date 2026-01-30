love = {
	_linewdith = 1,
	_color = rl.WHITE,
	timer = {
		getTime = function() return rl.GetTime() end
	},
	math = {
		random = function() return rl.GetRandomValue(0, 1) end
	},
	graphics = {

		getWidth = function() return rl.GetScreenWidth() end,
		getHeight = function() return rl.GetScreenHeight() end,
		push = function() graphics.push() end,
		translate = function(_x, _y) graphics.translate(_x,_y) end,
		scale = function(_s) graphics.scalef(_s) end,
		rotate = function(_a) graphics.rotate(_a) end,
		pop = function() graphics.pop() end,

		getLineWidth = function() return love._linewdith end,
		setLineWidth = function(_v)  love._linewdith = _v end,
		line = function(_x1, _y1, _x2, _y2)	graphics.drawline(_x1, _y1, _x2, _y2, love._color) end,
		getColor = function() return love._color.r /255, love._color.g/255, love._color.b/255, love._color.a  end,
		setColor = function(_r, _g, _b, _a)
			local r, g, b, a = 0, 0, 0, 0
			if type(_r) == 'table' then
				r = _r[1] * 255
				g = _r[2] * 255
				b = _r[3] * 255
				a = _r[4]
			elseif type(_r) == 'number' then
				r = _r * 255
				g = _g * 255
				b = _b * 255
				a = _a
			else
				r = _r.r; g = _r.g; b = _r.b; a = _r.a
			end
			love._color = rl.new("Color", r, g, b, a)
		end,
		rectangle = function(_mode, _x, _y, _w, _h)
			graphics.drawrect(_x, _y, _w, _h, love._color)
		end
	},
	mouse = {
		getPosition = function() return rl.GetMouseX(), rl.GetMouseY() end,

	}
}