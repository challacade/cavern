local function drawGameplay()
  love.graphics.setLineWidth(2)
  mapdata.map:drawLayer(mapdata.map.layers["Main_Tiles"])
end

return drawGameplay
