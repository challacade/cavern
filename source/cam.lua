cam = Camera(player.physics:getX(), player.physics:getY(), 0.5*scale)

function cam:update(dt)
  local lookX = player.physics:getX()
  local lookY = player.physics:getY()

  -- Camera can't pan outside the room
  if mapdata.room ~= nil then

    -- Normally you would divide gameWidth by 2, but you don't here because
    -- the camera is zoomed out, so gameWidth/Height is "doubled"

    local leftBound = mapdata.room.x + gameWidth
    if lookX < leftBound then
      lookX = leftBound
    end

    local rightBound = mapdata.room.x + mapdata.room.width - gameWidth
    if lookX > rightBound then
      lookX = rightBound
    end

    local upperBound = mapdata.room.y + gameHeight
    if lookY < upperBound then
      lookY = upperBound
    end

    local lowerBound = mapdata.room.y + mapdata.room.height - gameHeight
    if lookY > lowerBound then
      lookY = lowerBound
    end

  end

  cam:lookAt(lookX, lookY)
end
