require ('enemies')
maxw,maxh = love.window.getDesktopDimensions(display)
bullet = {}
bulletSpeed = 800
math.randomseed(os.time())
function bulletCreate(x,y)
	table.insert (bullet, {w = 15, h = 15 , x = x, y = y})
end
function bulletDraw()
 	for i,v in ipairs(bullet) do
 		love.graphics.draw(plasma, v.x, v.y)
 	end
 end 
function bulletNewPos(dt)
	for i,v in ipairs(bullet) do
		v.x = v.x + (v.dx * dt)
		v.y = v.y + (v.dy * dt)
	end
end
function bulletIsColliding()
 	col = false
 		for ien,ven in ipairs(enemy) do
 			for ibullet,vbullet in ipairs(bullet) do
 				if vbullet.x > ven.x then
 					col = true
 				end
 				if vbullet.x < 0 or vbullet.x > maxw then
 					table.remove(bullet, ibullet)
 				end
 				if vbullet.y < 0 or vbullet.y > maxh then
 					table.remove(bullet, ibullet)
 				end
 			end
 		end
 	return col
 end 

 function love.mousepressed(x,y,button)
 	for i,v in ipairs(player) do
		if button == 1 then
			pew:play()
			startX = v.x + 15
			startY = v.y + 15
			mouseX = x
			mouseY = y

			angle = math.atan2((mouseY - startY), (mouseX - startX))

			bulletDx = bulletSpeed * math.cos(angle)
			bulletDy = bulletSpeed * math.sin(angle)

			table.insert(bullet, {x = startX, y = startY, dx = bulletDx, dy = bulletDy})
		end
	end
end