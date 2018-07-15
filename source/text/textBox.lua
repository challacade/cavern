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
textBox.visible = true


function textBox:start(m)

  textBox.active = true

  -- Freezes everything (mostly)
  gameState.state = 0

  if m == "blaster" or m == "rocket" or m == "harpoon"
    or m == "aquaPack" or m == "health" then
    textBox:init("pickup")
  end
  
  if m == "failedLoad" then
    textBox:init("failedLoad")
  end
  
  if m == "intro" then
    textBox:init("intro")
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
    
    -- Draw black background
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.rectangle("fill", self.x * scale, self.y * scale,
      self.width * scale, self.height * scale)
    
    -- Draw the border of the box
    if self.visible then
      love.graphics.setColor(1, 1, 1, 1)
      love.graphics.setLineWidth(22 * scale)
      love.graphics.rectangle("line", self.x * scale, self.y * scale,
        self.width * scale, self.height * scale)
    end
    
    -- Draw text
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setFont(self.font)
    love.graphics.print(scroll.text, self.textX * scale, self.textY * scale)
  end

end


function textBox:init(type)

  if type == "pickup" then
    textBox.x = 180
    textBox.y = 180
    textBox.width = gameWidth - 360
    textBox.height = 410
    textBox.textX = textBox.x + 40
    textBox.textY = textBox.y + 226
    textBox.font = fonts.pickup
    textBox.visible = true
  end
  
  if type == "failedLoad" then
    textBox.x = 180
    textBox.y = 265
    textBox.width = gameWidth - 360
    textBox.height = 170
    textBox.textX = textBox.x + 40
    textBox.textY = textBox.y + 60
    textBox.font = fonts.pickup
    textBox.visible = true
  end
  
  if type == "intro" then
    textBox.x = -100
    textBox.y = -100
    textBox.width = gameWidth + 200
    textBox.height = gameHeight + 200
    textBox.textX = 100
    textBox.textY = 100
    textBox.font = fonts.menu.intro
    textBox.visible = false
  end

end
