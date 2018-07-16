-- Stores all data about the background
background = {}
background.img = sprites.environment.bg

function background:draw()
  
  love.graphics.setColor(1, 1, 1, 1)
  
  local imgW = self.img:getWidth()
  local imgH = self.img:getHeight()
  
  for i = 0, (mapdata.map.width * 128 / imgW) do
    for j = 0, (mapdata.map.height * 128 / imgH) do
      love.graphics.draw(self.img, i * imgW, j * imgH)
    end
  end
  
end
