-- blackScreen is used for fading to black and adding darkness to the screen

blackScreen = {}
blackScreen.state = 0 -- 0 is stable, 1 is getting dark, -1 is getting lighter
blackScreen.alpha = 0
blackScreen.time = 1 -- time in seconds for the blackScreen fade/unfade

function blackScreen:update(dt)

  if self.state ~= 0 then
    self.alpha = self.alpha + (self.state / self.time * dt)
  end

  if self.alpha < 0 then
    self.alpha = 0
    self.state = 0
  end

  if self.alpha > 1 then
    self.alpha = 1
    self.state = 0
  end

end

function blackScreen:draw()

  love.graphics.setColor(0, 0, 0, self.alpha)
  love.graphics.rectangle("fill", -20, -20, (gameWidth + 40) * scale, (gameHeight + 40) * scale)

end

function blackScreen:fadeIn(t)

  self.alpha = 1
  self.state = -1
  self.time = t or 1

end

function blackScreen:fadeOut(t)

  self.alpha = 0
  self.state = 1
  self.time = t or 1

end
