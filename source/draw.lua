local function drawGameplay()
  love.graphics.setLineWidth(2)

  -- Draw darkness wherever there is a wall object
  -- tiles will be drawn over this
  love.graphics.setColor(36, 31, 28, 255)
  for i,w in ipairs(mapdata.walls) do
    love.graphics.rectangle("fill", w.x, w.y, w.width, w.height)
  end
  love.graphics.setColor(255, 255, 255, 255)
  mapdata.map:drawLayer(mapdata.map.layers["Main_Tiles"])

  enemies:drawHealthBars()
  damages:draw()

  player:draw()

  -- Draw water and ripples after everything else to give underwater objects
  -- a blue tint (since the drawing is translucent)
  ripples:draw()
end

return drawGameplay
