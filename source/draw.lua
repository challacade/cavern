local function drawGameplay()
  love.graphics.setLineWidth(2)

  player:draw()

  -- Draw spike projectiles
  spikes:draw()

  -- draw all enemies
  enemies:draw()

  -- Draw trails
  trails:draw()

  -- Draw water and ripples after everything else to give underwater objects
  -- a blue tint (since the drawing is translucent)
  ripples:draw()

  -- Draw the ground
  love.graphics.setColor(63, 45, 29, 255)
  for i,w in ipairs(mapdata.walls) do

    -- Draw rocks on the surface of all walls
    -- Make every wall have direction values to tell which sides need rocks
    local surface = sprites.environment.rockySurface
    local offY = surface:getHeight()
    if w.up then
      for itr=0, (w.width/128)-1 do
        love.graphics.draw(surface, w.x + (itr * 128), w.y - offY)
      end
    end
    if w.down then
      for itr=0, (w.width/128)-1 do
        love.graphics.draw(surface, w.x + (itr * 128), w.y + w.height + offY, nil, nil, -1)
      end
    end
    if w.right then
      for itr=0, (w.height/128)-1 do
        love.graphics.draw(surface, w.x + w.width + offY, w.y + (itr * 128), math.pi/2)
      end
    end
    if w.left then
      for itr=0, (w.height/128)-1 do
        love.graphics.draw(surface, w.x - offY, w.y + (itr * 128), math.pi/2, nil, -1)
      end
    end

  end

  for i,w in ipairs(mapdata.walls) do

    -- Draw the full rectangle for each wall
    love.graphics.rectangle("fill", w.x, w.y, w.width, w.height)

    -- Note: this is done in a different for loop than the one above because
    -- the ground color needs to be drawn after all the surface rocks have been
    -- drawn. This is because some walls extend into the ground, so some walls
    -- are drawing rocky surfaces underground. These underground surfaces
    -- should not be seen, so these rectangle will cover those surfaces.

  end

  love.graphics.setColor(255, 255, 255, 255)
  --mapdata.map:drawLayer(mapdata.map.layers["Main_Tiles"])

  fires:draw()
  blasts:draw()
  damages:draw()
end

return drawGameplay
