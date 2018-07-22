function saveGame()
  gameState.saveCount = gameState.saveCount + 1
  gameState.player.x = player.physics:getX()
  gameState.player.y = player.physics:getY()
  local temp = Tserial.pack(gameState)
  love.filesystem.write("savefile.txt", temp)
  saveUtil:startMessage()
end

function loadGame()
  if love.filesystem.getInfo("savefile.txt") ~= nil then
    local temp = love.filesystem.read("savefile.txt")
    gameState = Tserial.unpack(temp, true)
  end

  player.physics:setPosition(gameState.player.x, gameState.player.y)
  player.health = gameState.player.maxHealth
  player.state = 1
  changeToMap(gameState.room)

  blackScreen:fadeIn(1)
end
