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

  end

  return enemy

end

return fishInit
