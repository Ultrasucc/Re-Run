maxw,maxh = love.window.getDesktopDimensions(display)
player = {}
function playerLoad()
table.insert(player, { x = (maxw / 2), y = (maxh / 2) - 20, w = 30, h = 30})
end
playerSpeed = 300
function playerUpdate(dt)
	for i,v in ipairs(player) do
		if 	love.keyboard.isDown('w' or 'up') then
			v.y = v.y - playerSpeed*dt
		end

		if love.keyboard.isDown('s' or 'down') then
			v.y = v.y + playerSpeed*dt
		end

		if love.keyboard.isDown('a' or 'left') then
			v.x = v.x - playerSpeed*dt
		end

		if love.keyboard.isDown('d' or 'right') then
			v.x = v.x + playerSpeed*dt
		end 

		if v.x < 0 then
			v.x = 0
		end
		if v.y < 0 then
			v.y = 0
		end
		if v.x > maxw - 30 then
			v.x = maxw - 30
		end
		if v.y > maxh - 30 then
			v.y = maxh - 30
		end
	end
end
function playerDraw()
	for i,v in ipairs(player) do
		love.graphics.draw(think, v.x, v.y)
	end
end