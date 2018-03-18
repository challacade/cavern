local function spikeInit(enemy, x, y, arg)

  -- Initialize physics
  local enW = 128
  local enH = 128
  if arg == "down" or arg == "up" then
    enH = 84
  else
    enW = 84
  end
  enemy.physics = world:newBSGRectangleCollider(x, y, enW, enH, 30)
  enemy.physics:setCollisionClass('Enemy')
  enemy.physics:setType('static')
  enemy.physics:setFixedRotation(true)
  -- We need this to access the table itself given the physics
  enemy.physics.parent = enemy

  -- Properties
  enemy.health = 10
  enemy.hitPower = 2
  enemy.barY = 62
  enemy.groundDir = "down"

  enemy.moveTimer = math.random(0.5, 3)
  enemy.moveDir = -1
  enemy.speed = 20

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
      spawnSpike(ex, ey, 1)
      spawnSpike(ex, ey, 2)
      spawnSpike(ex, ey, 3)
      spawnSpike(ex, ey, 4)
      spawnSpike(ex, ey, 5)

      self.stateTimer = 1
      self.state = 2
    end

    -- State 2: Wait until timer, then go back to state 0
    if self.state == 2 and self.stateTimer == 0 then
      self.state = 0
      self.moveTimer = 2.5
    end

  end

  return enemy

end

return spikeInit
