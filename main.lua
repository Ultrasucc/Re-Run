require("player")
require("bullets")
require("enemies")
require("powerups")
local anim8 = require("anim8.anim8")
Gamestate = require("hump.gamestate")
timer = 1
collision = "false"
math.randomseed(os.time())
maxw,maxh = love.window.getDesktopDimensions(display)
local game = {}
local menu = {}
local pause = {}
local dead = {}
function menu:draw()
	love.graphics.draw(mouse, maxw/2, maxh/2)
	love.graphics.draw(wasd, maxw/2 - 452, maxh/2)
	love.graphics.print("U S E F U L  I N F O R M A T I O N  I S  L O C A T E D", maxw/2 - 135, maxh/2 - 60)
	love.graphics.print("A T  T H E  T O P  O F  T H E  S C R E E N", maxw/2 - 105, maxh/2 - 36)
	love.graphics.print("P R E S S  E N T E R  T O  S T A R T", maxw/2 - 95 , maxh/2 - 12)
	love.graphics.print("P R E S S  E S C A P E  T O  Q U I T", maxw/2 - 95 , maxh/2 + 12)
	love.graphics.print("< - -C O N T R O L S - - >", maxw/2 - 65, maxh/2 + 84)
	love.graphics.print("T H E  T R I C K  I S  T O  R U N  F R O M  T H E  E N E M I E S  A N D  A T T E M P T  T O  K I L L  T H E M", maxw/2 - 218, maxh/2 - 72)
end
function highlight()
	love.graphics.rectangle("fill", maxw/2 - 95, maxh/2 - 12, 50, 20)
end
function menu:keyreleased(key, code)
	if key == 'return' then
		Gamestate.switch(game)
	end
    if key == 'escape' then
    	love.event.quit()
    end
end
function game:enter()
	enemySpawn()
	playerLoad()
	spawnpowerup()
end
function game:update(dt)
	playerUpdate(dt)
	bulletNewPos(dt)
	enemy:update(dt)
	enemymove(dt)
	print(col)
end
function game:draw()
	local BGSX = love.graphics.getWidth() / background:getWidth()
	local BGSY = love.graphics.getHeight() / background:getHeight() -- width and height scale of image, value taken from dividing width and height of the screen with the w and h of the image
	love.graphics.draw(background, 0, 0, 0, BGSX, BGSY)
	playerDraw()
	bulletDraw()
	enemy:draw()
	drawerup()
	love.graphics.print("Score = " .. score, maxw/2 - 20, 0)
	love.graphics.print("Enemies spawn 5s after dying", maxw/2 - 70, 12)
	love.graphics.print("Press Esc to quit", maxw/2 - 42, 24)
	love.graphics.print("Time left: " .. math.ceil(killTime), maxw/2 - 30, 36)
	love.graphics.print("Lives left: ".. lives, maxw/2 - 30, 48)
	love.graphics.print("Press P to pause", maxw/2 - 40, 60)
end
function game:keyreleased(key, code)
	if key == 'escape' then
		love.event.quit()
	end
	if key == 'p' then
		Gamestate.push(pause)
	end
	if lives <= 0 or lives < 1 or killTime <= 0 or killTime < 1 then
		Gamestate.switch(dead)
	end

end
function pause:draw()
	love.graphics.print("P A U S E D", maxw/2 - 22, maxh/2)
end
function pause:keyreleased(key, code)
	if key == 'p' then
		Gamestate.pop()
	end
end
--function dead:update(dt)
--	anim:update(dt)
--end
function dead:draw()
--	anim:draw(died, maxw/2 - 590, maxh/2 - 150)
	love.graphics.print("P R E S S  E S C A P E  T O  Q U I T", maxw/2 - 74, maxh - 150)
	--youdied:play()
end
function dead:keyreleased(key, code)
	if key == 'escape' then
		love.event.quit()
	end
end
function love.load()
	Gamestate.registerEvents()
	Gamestate.switch(menu)
	love.window.setMode(maxw, maxh, {resizable=true, fullscreen = true, vsync=false, minwidth=640, minheight=480})
	--youdied = love.audio.newSource("died.wav")
	--died = love.graphics.newImage("DS.png")
	--local grid = anim8.newGrid(1198, 300, died:getWidth(), died:getHeight())
	--anim = anim8.newAnimation(grid('1-12',1, '1-12',2, '1-12',3, '1-12',4, '1-12',5, '1-12',6), 0.1, pauseAtEnd)
	plasma = love.graphics.newImage("plasma.png")
	doink = love.audio.newSource("doinkt.wav", "static")
	think = love.graphics.newImage("player.png")
	pew = love.audio.newSource("pew.wav", "static")
	hurt = love.audio.newSource("oof.wav", "static")
	background = love.graphics.newImage("bg.png")
	mouse = love.graphics.newImage("mouse.png")
	wasd = love.graphics.newImage("wasd.png")
end
