local function batInit(enemy, x, y, arg)

  -- Initialize physics
  enemy.physics = world:newBSGRectangleCollider(x, y, 82, 82, 22)
  enemy.physics:setCollisionClass('Enemy')
  enemy.physics:setLinearDamping(2)
  enemy.physics:setFixedRotation(true)
  -- We need this to access the table itself given the physics
  enemy.physics.parent = enemy

  -- Properties
  enemy.health = 10
  enemy.hitPower = 2
  enemy.moveForce = 4500
  enemy.maxSpeed = 400
  enemy.barY = 62

  -- Sprite info
  enemy.sprite = sprites.enemies.flyer1

  function enemy:update(dt)
    local speed = speedFromVelocity( self.physics:getLinearVelocity() )
    if speed < self.maxSpeed then
      local ex, ey = self.physics:getPosition()
      local dir = toPlayerVector(ex, ey)
      dir = dir * self.moveForce
      self.physics:applyForce(dir:unpack())
    end
  end

  function enemy:draw()
    love.graphics.setColor(255, 255, 255, 255)

    local sprW = self.sprite:getWidth()
    local sprH = self.sprite:getHeight()
    local sprX, sprY = self.physics.body:getPosition()
    love.graphics.draw(self.sprite, sprX, sprY, nil, 1, 1, sprW/2, sprH/2)
  end

  return enemy

end

return batInit
