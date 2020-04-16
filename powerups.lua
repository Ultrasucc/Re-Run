require("enemies")
require("player")
local powerup = {}
local spawnchance = 1 -- drop chance for powerup things (down below it's 1 in X)
local maxpowerups = 1
function spawnpowerup(x,y,w,h)
    for i=maxpowerups, maxpowerups do
      powerup[#powerup + i] = {x = math.random(30, maxw - 30),
                    y = math.random(30, maxh - 30),
                    h = 15,
                    w = 15}
    end
    for i,v in ipairs(powerup) do
      for a,b in ipairs(player) do
        if b.x < v.x+30 and b.y < v.y+30 and b.x > v.x-15 and b.y > v.y-15 then
          table.remove(powerup, i)
          maxpowerups = maxpowerups - 1
        end
      end
    end
  end
function drawerup()
      for i,v in ipairs(powerup) do
        love.graphics.rectangle("fill", v.x, v.y , v.w, v.h)
      end
end
