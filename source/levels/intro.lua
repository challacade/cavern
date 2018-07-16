-- Handles everything during the intro sequence
-- Also calls loadGame when pressing "Continue"
intro = {}
intro.state = 0
intro.timer = 0

function intro:update(dt)
  
  if gameState.room ~= "rmIntro" then
    return
  end
  
  self.timer = updateTimer(self.timer, dt)
  
  if self.state == 1 and self.timer == 0 then
    
    textBox:start("intro")
    self.state = 2
    self.timer = 1
    
  end
  
  if self.state == 2 and self.timer == 0 then
    
    if scroll.text == "" then
      self.state = 3
      self.timer = 2
    end
    
  end
  
  if self.state == 3 and self.timer == 0 then
    
    self.state = 4
    blackScreen:fadeIn(3)
    player.physics:setPosition(512, 392)
    player.state = 1
    changeToMap("rm1")
    
  end
  
  -- Load the saved game (if it exists
  if self.state == 100 and self.timer == 0 then
    
    -- Reset the state
    self.state = 0
    
    if love.filesystem.getInfo("savefile.txt") == nil then
    
      -- No save file exists, return to the main menu
      changeToMap("rmMainMenu")
      textBox:start("failedLoad")
    
    else
    
      -- Load the game
      loadGame()
    
    end
  
  end
  
end
