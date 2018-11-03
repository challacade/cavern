function saveGame()
  gameState.saveCount = gameState.saveCount + 1
  gameState.player.x = player.physics:getX()
  gameState.player.y = player.physics:getY()
  gameState.player.weapon = player.weapon
  local temp = Tserial.pack(gameState)
  love.filesystem.write("savefile.txt", temp)
  saveUtil:startMessage()
  saveUtil:destroySave()

  -- Restore the player's health when the game saves
  player.health = gameState.player.maxHealth
end

function loadGame()
  if love.filesystem.getInfo("savefile.txt") ~= nil then
    local temp = love.filesystem.read("savefile.txt")
    gameState = Tserial.unpack(temp, true)
  end

  player.physics:setPosition(gameState.player.x, gameState.player.y)
  player.health = gameState.player.maxHealth
  player.weapon = gameState.player.weapon
  player.state = 1
  changeToMap(gameState.room)

  if gameState.room ~= "rm27" then
    soundManager:startMusic("cavern")
  end

  blackScreen:fadeIn(1)
end
