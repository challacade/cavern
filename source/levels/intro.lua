-- Handles everything during the intro sequence
-- Also calls loadGame when pressing "Continue"
intro = {}
intro.state = 0
intro.timer = 0
intro.skipMessage = false

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
      self.state = 2.5
      self.timer = 1.25
    end

  end

  if self.state == 2.5 and self.timer == 0 then

    soundManager:startMusic("intro")
    self.state = 3
    self.timer = 1.7

  end

  if self.state == 3 and self.timer == 0 then

    self.state = 4
    blackScreen:fadeIn(8)
    player.physics:setPosition(512, 260)
    player.state = -10
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

function intro:interrupt()

  if gameState.room ~= "rmIntro" then
    return
  end

  if self.skipMessage then
    scroll.text = ""
    scroll.messageObj = nil
    scroll.charTimer = 0
    self.state = 2
    self.timer = 0
    self.skipMessage = false
  else
    self.skipMessage = true
  end

end

function intro:drawInterrupt()

  if self.skipMessage and textBox.active and scroll.text ~= scroll.fullMessage then
    local w = gameWidth * scale
    local h = gameHeight * scale
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setFont(fonts.menu.intro)
    love.graphics.print("Skip?", w - 96 * scale, h - 52 * scale)
  end

end
