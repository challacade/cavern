-- Stores all clickable buttons on the main menu
-- By index: X, Y, Width, Height, Message
buttons = {}
buttons[1] = {376, 380, 360, 72, "New Game"}
buttons[2] = {376, 476, 360, 72, "Continue"}

-- Dimensions and offset for the small corner buttons (sound and GitHub)
local smSize = 72
local smOffset = 14

-- Place buttons 3 and 4 in the left and right corners respectively
buttons[3] = {smOffset, gameHeight - smSize - smOffset, smSize, smSize, ".sound"}
buttons[4] = {gameWidth - smSize - smOffset, gameHeight - smSize - smOffset, smSize, smSize, ".github"}

-- This value stores the message displayed at the bottom of the menu
buttons.message = ""

-- This function draws everything on the Main Menu
function menuDraw()

  if gameState.room == "rmMainMenu" then

    love.graphics.setFont(fonts.menu.title)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.printf("CAVERN", 0, 140 * scale, gameWidth * scale, "center")

    -- Start message off as nothing, will be updated if hovering over a button
    buttons.message = ""

    for _,b in ipairs(buttons) do

      -- Get attributes stored for the current button
      local bX = b[1] * scale;
      local bY = b[2] * scale;
      local bW = b[3] * scale;
      local bH = b[4] * scale;
      local bText = b[5];

      if buttons:mouseCheck(b) then -- if the mouse is over the button...

        -- Button border
        -- love.graphics.setColor(0.384, 0.604, 0.475) -- enemy color
        love.graphics.setColor(1, 1, 1) -- white
        love.graphics.setLineWidth(6)
        love.graphics.rectangle("line", bX, bY, bW, bH)

        -- Update the button message at the bottom of the screen
        if bText == "New Game" then
          buttons.message = "Start a new game - erases old save file"
        elseif bText == "Continue" then
          buttons.message = "Continue from where you left off"
        elseif bText == ".sound" then
          buttons.message = "Turn music and sound effects on or off"
        elseif bText == ".github" then
          buttons.message = "View the code on GitHub"
        end

      end

      love.graphics.setColor(1, 1, 1, 1)
      love.graphics.setFont(fonts.menu.button)

      if bText == ".sound" then
        if not soundOn then
          love.graphics.setColor(0.35, 0.35, 0.35, 0.5)
        end
        love.graphics.draw(sprites.ui.sound, bX + 15 * scale, bY + 9 * scale, 0, scale, scale)
      elseif bText == ".github" then
        love.graphics.draw(sprites.ui.github, bX + 9 * scale, bY + 8 * scale, 0, scale, scale)
      else
        love.graphics.printf(bText, bX, bY + 8 * scale, bW, "center")
      end

    end

  end

  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.setFont(fonts.menu.message)
  love.graphics.printf(buttons.message, 0, love.graphics.getHeight() - 80, love.graphics.getWidth(), "center")

end

-- Check if the mouse is inside the passed button
function buttons:mouseCheck(b)

  -- Get mouse coordinates
  local mx, my = love.mouse.getPosition()

  -- Get attributes stored for the passed button
  local bX = b[1] * scale;
  local bY = b[2] * scale;
  local bW = b[3] * scale;
  local bH = b[4] * scale;

  -- Compare coordinates to see if mouse is inside button
  if mx > bX and mx < bX+bW and my > bY and my < bY+bH then
    return true
  end

  return false

end

-- Called whenever the left mouse button is clicked
-- Checks if it clicked on a button, and does what that
-- button needs to do
function buttons:click()

  for i,b in ipairs(self) do

    -- If the mouse is on the current button...
    if buttons:mouseCheck(b) then

      -- The button has been clicked

      if i == 1 then -- New Game button

        -- This is the state for new game sequence
        intro.state = 1
        intro.timer = 1
        buttons.message = ""
        soundManager:musicFade()
        changeToMap("rmIntro")

      elseif i == 2 then -- Continue button

        -- This is the state for intro's load sequence
        intro.state = 100
        intro.timer = 1.5
        buttons.message = ""
        soundManager:musicFade()
        changeToMap("rmIntro")

      elseif i == 3 then -- Sound button

        -- Toggle sound to be on/off
        soundOn = not soundOn
        if soundOn then
          soundManager:startMusic("menu")
        else
          soundManager:musicFade()
        end

      elseif i == 4 then -- GitHub button

        -- Open the GitHub page for this game!
        love.system.openURL("https://github.com/kyleschaub/cavern")

      end

      soundManager:play("click")

    end

  end

end
