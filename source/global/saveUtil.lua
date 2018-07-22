-- Throughout the game, there are invisible save blocks.
-- When the player hits one of these, the game saves.
-- saveUtil stores these blocks and handles the save message.
saveUtil = {}
saveUtil.saveBlocks = {}

-- Info for the "Saving..." message
saveUtil.message = {}
saveUtil.message.state = 0
saveUtil.message.stateTimer = 0
saveUtil.message.text = "Saving..."
saveUtil.message.alpha = 0

function saveUtil:startMessage()
  
  saveUtil.message.state = 1
  
end

function saveUtil:update(dt)
  
  saveUtil.message.stateTimer = updateTimer(saveUtil.message.stateTimer, dt)
  
  -- State 1: Message fades in
  if saveUtil.message.state == 1 then
    
    saveUtil.message.alpha = saveUtil.message.alpha + (dt*1.5)
    
    if saveUtil.message.alpha >= 1 then
      
      saveUtil.message.alpha = 1
      saveUtil.message.state = 2
      saveUtil.message.stateTimer = 1
      
    end
    
  end
  
  -- State 2: Message is fully visible
  if saveUtil.message.state == 2 and saveUtil.message.stateTimer == 0 then
    saveUtil.message.state = 3
  end
  
  -- State 3: Message fades away
  if saveUtil.message.state == 3 then
    
    saveUtil.message.alpha = saveUtil.message.alpha - dt
    
    if saveUtil.message.alpha <= 0 then
      saveUtil.message.alpha = 0
      saveUtil.message.state = 0
    end
    
  end
  
end

function saveUtil:drawMessage()
  
  -- The message is only visible at states 1 and 2
  -- Also, only show the message if no message box is visible
  if saveUtil.message.state > 0 and textBox.active == false then
    
    love.graphics.setColor(1, 1, 1, saveUtil.message.alpha)
    love.graphics.setFont(fonts.menu.button)
    love.graphics.print(saveUtil.message.text, 10 * scale, 10 * scale)
    
  end
  
end