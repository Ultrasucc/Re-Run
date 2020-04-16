require("player")
enemy = {}
enemySpeed = 80
math.randomseed(os.time())
score = 0
enemyNumber = 5
testenemy = enemyNumber
killTimeStart = 8 -- time limit/ level
killTime = killTimeStart
maxw, maxh = love.window.getDesktopDimensions(display)
timer = 0
spawnTime = 5 -- delay of spawn in seconds
lives = 3 -- player lives
round = 4 -- this is the amount of time that is multiplied by delta time (1s) to add to time allowed for the next round
function enemySpawn(x,y,w,h)
  for a,b in ipairs(player) do
   for i = 1, enemyNumber do
      enemy[#enemy + 1] = {x = math.random(0 and b.x - 320, b.x + 300 and maxw - 64), y = math.random(0 and b.y - 320, b.y + 300 and maxh - 64), w = 64, h = 64}
   end
 end
    if #enemy <= enemyNumber then
      enemyNumber = enemyNumber + math.random(1,3) --increasing enemy amount by a random from 1 to 3
   end
   angery = love.graphics.newImage("enemy.png")
end
function collcheck(dt)
   for i,v in ipairs(enemy) do      --collision check for bullet vs enemy
     for a,b in ipairs(bullet) do
       if b.x < v.x+64 and b.y < v.y+64 and b.x > v.x-8 and b.y > v.y-8 then
         table.remove(enemy, i)
         table.remove(bullet, a)
         doink:play()
         score = score + 1
       end
     end
   end
  for i,v in ipairs(player) do      --collision check for player vs enemy
    for a,b in ipairs(enemy) do
      if v.x < b.x+64 and v.y < b.y+64 and v.x > b.x-30 and v.y > b.y-30 then
        table.remove(enemy, a)
        lives = lives - 1
        hurt:play()
      end
    end
  end
  return lives
end
function enemy:update(dt)
   killTime = killTime - dt
   		if killTime < 0 and #enemy > 0 then
      		killTime = 0
      	end
      	if killTime >=0 and #enemy == 0 then -- if there's remaining kill time and there are no enemies on the screen
         	killTime = killTime + round*dt -- , increase the round time by Xs
   		end
   if #enemy == 0 then -- if all enemies are dead, start the timer for the next round (5s)
      timer = timer + dt
      if timer > spawnTime then
         enemySpawn()
         timer = 0
      end
   end
   collcheck()
end
function enemy:draw()
	for i,v in ipairs(enemy) do
		love.graphics.draw(angery, v.x, v.y)
	end
end
function enemymove(dt)
  for a,b in ipairs(player) do
   for i,v in ipairs(enemy) do
       enemyDirectionX = b.x - v.x
       enemyDirectionY = b.y - v.y
       distance = math.sqrt(enemyDirectionX * enemyDirectionX + enemyDirectionY * enemyDirectionY)
   end
  end
   if distance ~= 0 then --can't divide by 0 or some shit, movement things towards the player
     for i,v in ipairs(enemy) do
        v.x = v.x + enemyDirectionX / distance * enemySpeed * dt
        v.y = v.y + enemyDirectionY / distance * enemySpeed * dt
     end
   end
end
