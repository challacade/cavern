-- Controls overall display of scrollText messages

textBox = {}

textBox.active = false

-- Box position and dimensions
textBox.x = 100
textBox.y = 100
textBox.width = gameWidth - 200
textBox.height = 400

-- Where the text will be drawn within the box
textBox.textX = textBox.x + 100
textBox.textY = textBox.y + 100

-- Misc textBox settings
textBox.font = fonts.pickup


function textBox:start(m)

  textBox.active = true

  -- Freezes everything (mostly)
  gameState.state = 0

  if m == "blaster" or m == "rocket" or m == "harpoon" then
    textBox:init("pickup")
  end

  scroll:showMessage(m)

end


function textBox:update(dt)

  if self.active and scroll.messageObj == nil then
    self.active = false
    gameState.state = 1
  end

end


function textBox:draw()

  if self.active then
    -- Draw box
    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.rectangle("fill", self.x * scale, self.y * scale,
      self.width * scale, self.height * scale)
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.setLineWidth(12 * scale)
    love.graphics.rectangle("line", self.x * scale, self.y * scale,
      self.width * scale, self.height * scale)
    -- Draw text
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.setFont(self.font)
    love.graphics.print(scroll.text, self.textX * scale, self.textY * scale)
  end

end


function textBox:init(type)

  if type == "pickup" then
    textBox.x = 180
    textBox.y = 224
    textBox.width = gameWidth - 360
    textBox.height = 320
    textBox.textX = textBox.x + 40
    textBox.textY = textBox.y + 140
    textBox.font = fonts.pickup
  end

end
