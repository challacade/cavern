-- Ripple objects are small ripple animations on top of all bodies of water
ripples = {}

-- Spritesheet that ripples use
ripples.spr = sprites.environment.waterSheet

-- This is the grid that all ripple objects use for animations
local w = ripples.spr:getWidth()
local h = ripples.spr:getHeight()
ripples.grid = anim8.newGrid(64, 64, w, h)

function spawnRipple(x, y)

  local ripple = {}
  ripple.x = x
  ripple.y = y

  ripple.animation = anim8.newAnimation(ripples.grid('1-20', 1), 0.1)
  ripple.animation:gotoFrame(math.random(1, 20))

  table.insert(ripples, ripple)

end

-- Updates the anim8 animation for all ripple objects
function ripples:update(dt)

  for i,r in ipairs(self) do
    r.animation:update(dt)
  end

end

-- Draws the anim8 animation for all ripple objects
function ripples:draw()

  love.graphics.setColor(0.388, 0.502, 0.541, 0.471)

  for i,r in ipairs(self) do
    r.animation:draw(self.spr, r.x, r.y)
  end

  for i,w in ipairs(mapdata.water) do
    love.graphics.rectangle("fill", w.x, w.y, w.width, w.height)
  end

end

function ripples:destroy()

  for i=#ripples,1,-1 do
    table.remove(ripples, i)
  end

end
