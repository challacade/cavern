-- Stores all data about the background
background = {}
background.img = sprites.environment.bg

function background:draw()
  
  love.graphics.setColor(1, 1, 1, 1)
  
  local imgW = self.img:getWidth()
  local imgH = self.img:getHeight()
  
  for i=0,10 do
    for j=0,5 do
      love.graphics.draw(self.img, i * imgW, j * imgH)
    end
  end
  
end
