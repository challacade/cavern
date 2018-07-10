local function drawGameplay()
  love.graphics.setLineWidth(2)

  player:draw()

  -- Draw spike projectiles
  spikes:draw()

  -- Draw enemy projectiles
  enemyProjectiles:draw()
  
  -- Draw eggs from the final boss
  eggs:draw()

  -- draw all enemies
  enemies:draw()

  -- draw all weapons
  weapons:draw()

  -- Draw trails
  trails:draw()

  -- Draw water and ripples after everything else to give underwater objects
  -- a blue tint (since the drawing is translucent)
  ripples:draw()

  -- Destroys all walls (including breakable ones)
  local drawWalls = require("source/levels/drawWalls")
  drawWalls()

  love.graphics.setColor(1, 1, 1, 1)
  --mapdata.map:drawLayer(mapdata.map.layers["Main_Tiles"])

  particles:draw()
  fires:draw()
  blasts:draw()
  damages:draw()
end

return drawGameplay
