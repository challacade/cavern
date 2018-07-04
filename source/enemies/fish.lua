local function fishInit(enemy, x, y, arg)

  -- Initialize physics
  enemy.physics = world:newBSGRectangleCollider(x, y, 92, 64, 14)
  enemy.physics:setCollisionClass('Enemy')
  enemy.physics:setLinearDamping(2)
  enemy.physics:setFixedRotation(true)
  -- We need this to access the table itself given the physics
  enemy.physics.parent = enemy

  -- Properties
  enemy.health = 10
  enemy.hitPower = 6
  enemy.moveForce = 2400
  enemy.maxSpeed = 500
  enemy.barY = 80

  enemy.sprite = sprites.enemies.starfish

  function enemy:update(dt)
    if player.submerged then -- only chase the player if he is underwater
      local speed = speedFromVelocity( self.physics:getLinearVelocity() )
      if speed < self.maxSpeed then
        local ex, ey = self.physics:getPosition()
        local dir = toPlayerVector(ex, ey)
        dir = dir * self.moveForce
        self.physics:applyForce(dir:unpack())
      end
    end
  end

  function enemy:draw()
    local sprX, sprY = self.physics.body:getPosition()
    -- Draw the body

    sprW = self.sprite:getWidth()
    sprH = self.sprite:getHeight()

    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.draw(self.sprite, sprX, sprY, rotate, 1, 1, sprW/2, sprH/2)

    -- Get info to determine rotation value for the eye
    local dir = toPlayerVector(sprX, sprY)
    local vx, vy = dir:normalized():unpack()
    rotate = math.atan2(vy, vx)

    -- Draw the eye
    sprW = sprites.enemies.flyerEye:getWidth()
    sprH = sprites.enemies.flyerEye:getHeight()
    love.graphics.draw(sprites.enemies.flyerEye, sprX, sprY, rotate, 1, 1, sprW/2, sprH/2)
  end

  return enemy

end

return fishInit
