-- Stores all data about the background
background = {}
background.x = 0
background.y = 0
background.img = sprites.environment.bg
background.tileSize = 512

-- PARALLAX

-- Relative position of the background compared to the camera
background.relX = 0
background.relY = 0

-- Stores the position of the camera in the previous frame
background.oldCamX = 0
background.oldCamY = 0

-- Used to help with tracking the change in background position
background.diffBufferX = 0
background.diffBufferY = 0

-- Number of pixels the camera has to move before the background moves
background.speed = 2

-- calculate parallax positioning
function background:update(dt)

  local camX, camY = cam:position()
  local diffX = camX - background.oldCamX
  local diffY = camY - background.oldCamY

  -- Background position always at (-768, -768) relative to camera position
  background.x = camX - 1920
  background.y = camY - 1536

  background.relX = background.relX - (diffX / background.speed)
  background.relY = background.relY - (diffY / background.speed)

  if background.relX < -1 * background.tileSize then
    background.relX = background.relX + background.tileSize
  end

  if background.relX > background.tileSize then
    background.relX = background.relY - background.tileSize
  end

  if background.relY < -1 * background.tileSize then
    background.relY = background.relY + background.tileSize
  end

  if background.relY > background.tileSize then
    background.relY = background.relY - background.tileSize
  end

  background.oldCamX = camX
  background.oldCamY = camY

end

function background:reset()

  background.relX = 0
  background.relY = 0
  background.diffBufferX = 0
  background.diffBufferY = 0

  local camX, camY = cam:position()
  background.x = camX - 1920
  background.y = camY - 1536

  background.oldCamX = camX
  background.oldCamY = camY

end

function background:draw()

  love.graphics.setColor(1, 1, 1, 1)

  if mapdata.map == maps.rmIntro then
    love.graphics.setColor(0, 0, 0, 1)
  end

  local imgW = self.img:getWidth()
  local imgH = self.img:getHeight()

  for i = 0, 8 do -- number of tiles to cover the width of the camera
    for j = 0, 6 do -- number of tiles to cover the height of the camera
      love.graphics.draw(self.img, background.x + background.relX + (i * imgW),
        background.y + background.relY + (j * imgH))
    end
  end

end
