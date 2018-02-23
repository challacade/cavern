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

  -- Handles most updating for the game
  local updateGameplay = require("source/update")
  updateGameplay(dt)

  debug = mapdata.room.height

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

  love.graphics.print(debug)
  love.graphics.print(debug2, 0, 20)

end

function love.mousepressed( x, y, button, istouch )

  -- If the left mouse button is pressed
  if button == 1 then
    player:shoot()
  end

end
