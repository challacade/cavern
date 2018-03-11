local function drawGameplay()
  love.graphics.setLineWidth(2)

  love.graphics.setColor(255, 255, 255, 255)
  mapdata.map:drawLayer(mapdata.map.layers["Main_Tiles"])

  enemies:drawHealthBars()
  damages:draw()
end

return drawGameplay
