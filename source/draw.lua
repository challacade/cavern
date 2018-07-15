local function drawGameplay()
  love.graphics.setLineWidth(2)
  
  -- Draw the credits (only in rmCredits)
  credits:draw()

  -- Draw the player
  player:draw()

  -- Draw spike projectiles
  spikes:draw()

  -- Draw enemy projectiles
  enemyProjectiles:draw()
  
  -- Draw eggs from the final boss
  eggs:draw()

  -- draw all enemies (except final boss)
  enemies:draw(false)
  
  -- draw final boss (boss must appear over other enemies)
  enemies:draw(true)

  -- draw all weapons
  weapons:draw()

  -- Draw trails
  trails:draw()

  -- Draw water and ripples after everything else to give underwater objects
  -- a blue tint (since the drawing is translucent)
  ripples:draw()

  -- Draws all walls (including breakable ones)
  local drawWalls = require("source/levels/drawWalls")
  drawWalls()

  love.graphics.setColor(1, 1, 1, 1)
  --mapdata.map:drawLayer(mapdata.map.layers["Main_Tiles"])

  particles:draw()
  fires:draw()
  blasts:draw()
  damages:draw()
  pickups:draw()
  
  if gameState.room == "rmBoss" then
    
    -- find the boss object
    for _,e in ipairs(enemies) do
      if e.type == "boss" then
        e:bossBar()
      end
    end
    
  end
  
end

return drawGameplay
