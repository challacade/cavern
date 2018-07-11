-- Eggs that the final boss drops
eggs = {}

function eggs:spawn(x)
  
  local egg = {}
  egg.width = 100
  egg.height = 100
  
  egg.power = 7 -- damage taken by player when colliding
  
  egg.physics = gravWorld:newBSGRectangleCollider(x, 200, egg.width, egg.height, 10)
  egg.physics:setFixedRotation(true)
  egg.physics:setCollisionClass('Particle')
  
  table.insert(eggs, egg)
  
end

function eggs:update(dt)

  for i=#eggs,1,-1 do
    
    local ex, ey = eggs[i].physics:getPosition()
    local width = eggs[i].width
    local dmg = eggs[i].power
    
    -- Check collision with player
    -- Note: since eggs are in a different physics world
    -- than the player, this is handled differently than
    -- most other collisions in the game
    
    if distToPlayer(ex, ey) < width then
      player:hurt(dmg)
    end
    
    -- Crash into the ground
    
    if ey > 1280 then
      
      -- Egg has hit the ground, hatch
      spawnEnemy(ex-(width/2), 1280, "bat")
      
      eggs[i].physics:destroy()
      table.remove(eggs, i)
    
    end
  end

end

function eggs:draw()
    
  for _,e in ipairs(self) do
    local ex, ey = e.physics:getPosition()
    local spr = sprites.enemies.egg
    love.graphics.draw(spr, ex, ey, nil, 1, 1, spr:getWidth()/2, spr:getHeight()/2)
  end
    
end
