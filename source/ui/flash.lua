-- Flashes cause the screen to go white
-- Similar to blackScreen, but needs to be its own class

flash = {}
flash.state = 0 -- 0 is stable, 1 is getting dark, -1 is getting lighter
flash.alpha = 0
flash.time = 1 -- time in seconds for the flash fade/unfade

-- if this is true, the white screen fades in and immediately out
flash.flashing = false

function flash:update(dt)

  if self.state ~= 0 then
    self.alpha = self.alpha + (self.state / self.time * dt)
  end

  if self.alpha < 0 then
    self.alpha = 0
    self.state = 0
    self.flashing = false
  end

  if self.alpha > 1 then
    self.alpha = 1
    self.state = 0
    
    if self.flashing then
      self.state = -1
    end    
  end

end

function flash:draw()
  
  love.graphics.setColor(1, 1, 1, self.alpha)
  love.graphics.rectangle("fill", -20, -20, (gameWidth + 40) * scale, (gameHeight + 40) * scale)
  
end

function flash:fadeIn(t)

  self.alpha = 1
  self.state = -1
  self.time = t or 1

end

function flash:fadeOut(t)

  self.alpha = 0
  self.state = 1
  self.time = t or 1

end

function flash:flash(t)
  
  self.flashing = true
  flash:fadeOut(t)
  
end
