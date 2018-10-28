local function drawWalls()

  -- This function, given a wall object, will draw the rocks for it
  local function singleWallRocks(wall)

    if wall.dontDraw then
      return
    end

    -- Draw rocks on the surface of all walls
    -- Make every wall have direction values to tell which sides need rocks
    local surface = sprites.environment.rockySurface
    local offY = surface:getHeight()
    if wall.up then
      for itr=0, (wall.width/128)-1 do
        love.graphics.draw(surface, wall.x + (itr * 128), wall.y - offY)
      end
    end
    if wall.down then
      for itr=0, (wall.width/128)-1 do
        love.graphics.draw(surface, wall.x + (itr * 128), wall.y + wall.height + offY, nil, nil, -1)
      end
    end
    if wall.right then
      for itr=0, (wall.height/128)-1 do
        love.graphics.draw(surface, wall.x + wall.width + offY, wall.y + (itr * 128), math.pi/2)
      end
    end
    if wall.left then
      for itr=0, (wall.height/128)-1 do
        love.graphics.draw(surface, wall.x - offY, wall.y + (itr * 128), math.pi/2, nil, -1)
      end
    end

  end

  -- Draw the ground
  love.graphics.setColor(1, 1, 1, 1)

  for i,w in ipairs(mapdata.walls) do
    singleWallRocks(w)
  end

  for i,b in ipairs(breakables) do
    singleWallRocks(b)
  end

  for i,w in ipairs(mapdata.walls) do

    if w.dontDraw == false then

      -- Draw the full rectangle for each wall
      --love.graphics.rectangle("fill", w.x, w.y, w.width, w.height)

      --[[
      love.graphics.setColor(1, 1, 1, 1)

      local spr = sprites.environment.wall

      for itrX=0, (w.width/128)-1 do
        for itrY = 0, (w.height/128)-1 do
          love.graphics.draw(spr, w.x + (itrX * 128), w.y + (itrY * 128))
        end
      end

      ]]

      -- Note: this is done in a different for loop than the one above because
      -- the ground color needs to be drawn after all the surface rocks have been
      -- drawn. This is because some walls extend into the ground, so some walls
      -- are drawing rocky surfaces underground. These underground surfaces
      -- should not be seen, so these rectangles will cover those surfaces.

    end

  end

  for i,b in ipairs(breakables) do

    love.graphics.setColor(1, 1, 1, 1)

    local spr = sprites.environment.wall

    for itrX=0, 1 do
      for itrY = 0, 1 do
        love.graphics.draw(spr, b.x + (itrX * 128), b.y + (itrY * 128))
      end
    end

    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.draw(sprites.environment.crack, b.x + 128, b.y + 128, b.crackRot, 1, 1, 90, 90)

  end
end

return drawWalls
