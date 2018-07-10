-- Eggs that the final boss drops
eggs = {}

function eggs:spawn(x)
  
  local egg = {}
  
  egg.physics = gravWorld:newBSGRectangleCollider(x, 200, 100, 100, 10)
  egg.physics:setFixedRotation(true)
  egg.physics:setCollisionClass('Particle')
  
  table.insert(eggs, egg)
  
end

function eggs:update(dt)

  for i=#eggs,1,-1 do
    local ex, ey = eggs[i].physics:getPosition()
    if ey > 1280 then
      
      -- Egg has hit the ground, hatch
      spawnEnemy(ex, 1280, "spike", "down")
      
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
