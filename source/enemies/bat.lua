local function batInit(enemy, x, y)

  -- Initialize physics
  enemy.physics = world:newCircleCollider(x, y, 24)
  enemy.physics:setCollisionClass('Enemy')
  enemy.physics:setLinearDamping(2)
  -- We need this to access the table itself given the physics
  enemy.physics.parent = enemy

  -- Properties
  enemy.health = 10
  enemy.hitPower = 2
  enemy.moveForce = 2000
  enemy.maxSpeed = 400

  function enemy:update(dt)
    local speed = speedFromVelocity( self.physics:getLinearVelocity() )
    if speed < self.maxSpeed then
      local ex, ey = self.physics:getPosition()
      local fx, fy = playerVector(ex, ey)
      self.physics:applyForce(fx * self.moveForce, fy * self.moveForce)
    end
  end

  return enemy

end

return batInit
