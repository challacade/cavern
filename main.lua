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
  drawPhysics = true

end

function love.update(dt)

  if gameState.state == 1 then
    -- Handles most updating for the game
    local updateGameplay = require("source/update")
    updateGameplay(dt)
  end

  scroll:update(dt)
  textBox:update(dt)

  --debug = saveUtil.saveBlock.x
  --debug2 = gameState.saveCount

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
  
  saveUtil:drawMessage()

  blackScreen:draw()
  flash:draw()
  
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.print(debug, 0, 100)
  love.graphics.print(debug2, 0, 120)

end

function love.mousepressed( x, y, button, istouch )
  if button == 1 and gameState.room == "rmMainMenu" then
    buttons:click()
  end
end

function love.keypressed(key, scancode, isrepeat)
  if key == "space" then
    player:swapWeapon()
  end
  if key == "m" then
    --scroll:showMessage("blaster")
    textBox:start("blaster")
  end
  if key == "p" then
    local px, py = player.physics:getPosition()
    damages:spawnDamage(px, py, 13)
  end
  if key == "z" then
    shake:start(1, 16, 0.01, 2)
  end
  if key == "k" then
    spawnParticle(player.physics:getX(), player.physics:getY(), "break", vector(-3500, -3500))
  end
  if key == "3" then
    player.weapon = 3
  end
  if key == "backspace" then
    if drawPhysics then
      drawPhysics = false
    else
      drawPhysics = true
    end
  end
  if key == "k" then
    saveGame()
  end
  if key == "l" then
    loadGame()
  end
  if key == "1" then
    player.weapon = 1
  end
  if key == "2" then
    player.weapon = 2
  end
  if key == "b" then
    flash:fadeIn(1)
  end
  if key == "n" then
    flash:flash(2)
  end
end
