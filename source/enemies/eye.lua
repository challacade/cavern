eyes = {}

function spawnEye(x, y, rot, scale, spr, args)

  local eye = {}
  eye.x = x
  eye.y = y
  eye.rot = rot
  eye.scale = scale
  eye.spr = spr
  eye.id = id
  eye.args = args

  eye.dead = false

  function eye:update(dt, x, y, rot)

    eye.x = x
    eye.y = y

    -- Only look at the player if the player is alive
    if player.health > 0 then
      eye.rot = rot
    end

  end

  function eye:draw()

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(self.spr, self.x, self.y, self.rot, self.scale, self.scale, self.spr:getWidth()/2, self.spr:getHeight()/2)

  end

  return eye
  --table.insert(eyes, eye)

end
