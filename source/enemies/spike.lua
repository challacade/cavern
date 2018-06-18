local function spikeInit(enemy, x, y, arg)

  -- Initialize physics
  enemy.physics = world:newBSGRectangleCollider(x, y, 128, 128, 30)
  enemy.physics:setCollisionClass('Enemy')
  enemy.physics:setType('static')
  enemy.physics:setFixedRotation(true)
  -- We need this to access the table itself given the physics
  enemy.physics.parent = enemy

  -- Properties
  enemy.health = 10
  enemy.hitPower = 2
  enemy.barY = 62
  enemy.groundDir = arg
  enemy.id = math.random()

  enemy.moveTimer = math.random(0.5, 3)
  enemy.moveDir = -1
  enemy.speed = 28

  enemy.state = 0
  enemy.stateTimer = 0

  function enemy:update(dt)

    self.moveTimer = updateTimer(self.moveTimer, dt)
    self.stateTimer = updateTimer(self.stateTimer, dt)

    if self.moveTimer == 0 and self.state == 0 then
      self.moveDir = self.moveDir * -1
      self.stateTimer = 0.5
      self.state = 1 -- prepping for spikes
    end

    -- State 0: Moving slowly, not really doing anything
    if self.state == 0 then
      if self.groundDir == "up" or self.groundDir == "down" then
        self.physics:setX(self.physics:getX() + (self.moveDir * dt * self.speed))
      else
        self.physics:setY(self.physics:getY() + (self.moveDir * dt * self.speed))
      end
    end

    -- State 1: Freezing after moving, spawn spikes after timer
    if self.state == 1 and self.stateTimer == 0 then

      local ex, ey = self.physics:getPosition()
      spawnSpike(ex, ey, 1, self.id, self.groundDir)
      spawnSpike(ex, ey, 2, self.id, self.groundDir)
      spawnSpike(ex, ey, 3, self.id, self.groundDir)
      spawnSpike(ex, ey, 4, self.id, self.groundDir)
      spawnSpike(ex, ey, 5, self.id, self.groundDir)

      self.stateTimer = 1
      self.state = 2
    end

    -- State 2: Wait until timer, then go back to state 0
    if self.state == 2 and self.stateTimer == 0 then
      self.state = 0
      self.moveTimer = 2.5
    end

  end

  function enemy:draw()

  end

  return enemy

end

return spikeInit
