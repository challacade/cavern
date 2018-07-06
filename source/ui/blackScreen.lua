-- blackScreen is used for fading to black and adding darkness to the screen

blackScreen = {}
blackScreen.state = 0 -- 0 is stable, 1 is getting dark, -1 is getting lighter
blackScreen.alpha = 0
blackScreen.time = 1 -- time in seconds for the blackScreen fade/unfade

-- blackScreen is also used for making the screen turn red when drowning
blackScreen.red = false
blackScreen.fullRedAlpha = 0.25

function blackScreen:update(dt)

  if self.state ~= 0 then
    self.alpha = self.alpha + (self.state / self.time * dt)
  end

  if self.alpha < 0 then
    self.alpha = 0
    self.state = 0
    self.red = false
  end

  if self.alpha > 1 then
    self.alpha = 1
    self.state = 0
  end

  if self.red and self.alpha > self.fullRedAlpha then
    self.alpha = self.fullRedAlpha
    self.state = 0
  end

end

function blackScreen:draw()

  local red = 0
  if self.red then
    red = 1
  end
  love.graphics.setColor(red, 0, 0, self.alpha)
  love.graphics.rectangle("fill", -20, -20, (gameWidth + 40) * scale, (gameHeight + 40) * scale)

end

function blackScreen:fadeIn(t)

  self.alpha = 1
  self.state = -1
  self.time = t or 1
  self.red = false

end

function blackScreen:fadeOut(t)

  self.alpha = 0
  self.state = 1
  self.time = t or 1
  self.red = false

end

function blackScreen:setRed()

  self.alpha = 0
  self.state = 1
  self.time = 1
  self.red = true

end

function blackScreen:removeRed()

  self.state = -1
  self.time = 1
  self.red = true

end
