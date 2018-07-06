-- blackScreen is used for fading to black and adding darkness to the screen

blackScreen = {}
blackScreen.alpha = 0

function blackScreen:draw()

  love.graphics.setColor(0, 0, 0, self.alpha)
  love.graphics.rectangle("fill", -20, -20, (gameWidth + 40) * scale, (gameHeight + 40) * scale)

end
