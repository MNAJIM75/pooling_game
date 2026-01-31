function game_init()
	
end

function game_update(dt)

end

function game_draw()
end

function draw_triangle(x1, y1, x2, y2)
	local v_start = vector.new(x1, y1)
	local v_end = vector.new(x2, y2)
	rl.DrawLineV(v_start, v_end, rl.GREEN)
	local dist, angle = vector.distance(v_start, v_end)
	
end

function game_close()

end
