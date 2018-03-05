function love.load()

  -- This function configures game window and performs additional setup
  require("source/startup/startup")
  startup()

  -- Debug value, comment out for final game
  debug = 0
  debug2 = 0

  -- TEMPORARY! Just a test enemy
  --spawnEnemy(500, 200, "bat")

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
end
