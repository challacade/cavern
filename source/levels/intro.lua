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
  
  -- Load the saved game (if it exists
  if self.state == 100 and self.timer == 0 then
    
    -- Reset the state
    self.state = 0
    
    if love.filesystem.getInfo("savefile.txt") == nil then
    
      -- No save file exists, return to the main menu
      changeToMap("rmMainMenu")
    
    else
    
      -- Load the game
      loadGame()
    
    end
  
  end
  
end
