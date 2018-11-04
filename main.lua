function love.load()

  -- This function configures game window and performs additional setup
  require("source/startup/startup")
  startup()

  -- Debug value, comment out for final game
  debug = 0
  debug2 = 0

  -- Temporary, used for drawing Explosion radius before particles
  expX = 0
  expY = 0

  -- Temporary, used to determine if physics will be drawn
  drawPhysics = false

end

function love.update(dt)

  if gameState.state == 1 then
    -- Handles most updating for the game
    local updateGameplay = require("source/update")
    updateGameplay(dt)
  end

  scroll:update(dt)
  textBox:update(dt)

end

function love.draw()

  cam:attach()

    -- Handles most drawing for the game
    local drawGameplay = require("source/draw")
    drawGameplay()

    -- Draw the colliders for all physics objects
    -- Commented out for final game, used for debugging
    if drawPhysics then
      love.graphics.setLineWidth(2)
      world:draw(150)
      gravWorld:draw(150)
    end

  cam:detach()

  menuDraw()

  textBox:draw()
  intro:drawInterrupt()

  saveUtil:drawMessage()

  blackScreen:draw()
  flash:draw()

  --[[
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.print(debug, 0, 100)
  love.graphics.print(debug2, 0, 120)
  ]]

end

function love.mousepressed( x, y, button, istouch )

  -- Interrupts the intro text
  intro:interrupt()

  -- Checks for button clicks on the main menu
  if button == 1 and gameState.room == "rmMainMenu" then
    buttons:click()
  end

end

function love.keypressed(key, scancode, isrepeat)

  -- Interrupts the intro text
  intro:interrupt()

  if key == "space" then
    player:swapWeapon()
  end

  if key == "backspace" then
    if drawPhysics then
      drawPhysics = false
    else
      drawPhysics = true
    end
  end

end

function love.wheelmoved(x, y)

  -- Change weapons
  if y < 0 then
      player:swapWeapon()
  elseif y > 0 then
      player:swapWeapon(true)
  end

end
