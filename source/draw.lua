local function drawGameplay()
  love.graphics.setLineWidth(2)

  -- Draw darkness wherever there is a wall object
  -- tiles will be drawn over this
  --love.graphics.setColor(36, 31, 28, 255)
  love.graphics.setColor(160, 90, 44, 255)
  for i,w in ipairs(mapdata.walls) do

    love.graphics.rectangle("fill", w.x, w.y, w.width, w.height)

    -- Draw rocks on the surface of all walls
    -- Make every wall have direction values to tell which sides need rocks
    local surface = sprites.environment.rockySurface
    local offY = surface:getHeight()
    for itr=0, (w.width/128)-1 do
      love.graphics.draw(surface, w.x + (itr * 128), w.y - offY);
    end

  end
  love.graphics.setColor(255, 255, 255, 255)
  --mapdata.map:drawLayer(mapdata.map.layers["Main_Tiles"])


  player:draw()

  -- Draw water and ripples after everything else to give underwater objects
  -- a blue tint (since the drawing is translucent)
  ripples:draw()

  enemies:drawHealthBars()
  damages:draw()
end

return drawGameplay
