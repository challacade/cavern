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
    world:draw(150)

    love.graphics.setColor(180, 0, 0, 120)
    love.graphics.circle("fill", expX, expY, 350, 100)

  cam:detach()

  textBox:draw()

  love.graphics.print(debug)
  love.graphics.print(debug2, 0, 20)

end

function love.mousepressed( x, y, button, istouch )

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
end
