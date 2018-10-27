local function fishInit(enemy, x, y, arg)

  -- Initialize physics
  enemy.physics = world:newBSGRectangleCollider(x, y, 106, 106, 26)
  enemy.physics:setCollisionClass('Enemy')
  enemy.physics:setLinearDamping(2)
  enemy.physics:setFixedRotation(true)
  -- We need this to access the table itself given the physics
  enemy.physics.parent = enemy

  -- Properties
  enemy.health = 18
  enemy.hitPower = 6
  enemy.moveForce = 5000
  enemy.maxSpeed = 500
  enemy.barY = 80

  enemy.sprite = sprites.enemies.starfish
  enemy.rotate = 0
  enemy.slowRotSpeed = math.pi/160
  enemy.fastRotSpeed = math.pi/10
  enemy.rotSpeed = enemy.slowRotSpeed
  enemy.rotTween = nil
  enemy.timeBetweenShots = 0.8

  enemy.stateTimer = 0
  enemy.state = 0

  enemy.eye = spawnEye(x, y, 0, 1, sprites.enemies.flyerEye)

  function enemy:update(dt)

    self.stateTimer = updateTimer(self.stateTimer, dt)

    -- State 0: idle
    if self.state == 0 and self:inSight() then
      self.state = 1
      self.stateTimer = self.timeBetweenShots
      self.timeBetweenShots = 1.5
    end

    -- State 1: chasing player, start shooting process after timer is up
    if self.state == 1 then

      if self.stateTimer <= 0 then
        self.state = 1.5
        local tweenTo = self.fastRotSpeed
        self.rotTween = flux.to(self, 0.5, {rotSpeed = tweenTo}):ease("sineinout")
      end

      local speed = speedFromVelocity( self.physics:getLinearVelocity() )
      local ex, ey = self.physics:getPosition()
      if speed < self.maxSpeed then
        local dir = toPlayerVector(ex, ey)
        dir = dir * self.moveForce
        self.physics:applyForce(dir:unpack())
      end

    end

    -- State 1.5: After first tween is done, shoot and slow down rotSpeed
    local ex, ey = self.physics:getPosition()
    if self.state == 1.5 and self.rotSpeed == self.fastRotSpeed then
      self.state = 2
      local tweenTo = self.slowRotSpeed
      self.rotTween = flux.to(self, 0.5, {rotSpeed = tweenTo}):ease("cubicout")

      -- Shoot bullet
      spawnEnemyProj(ex, ey, toPlayerVector(ex, ey), "fish")
    end

    -- State 2: After shooting, slowing down
    if self.state == 2 and self.rotSpeed == self.slowRotSpeed then
      self.state = 0
    end

    self.rotate = self.rotate + self.rotSpeed

    self.eye:update(dt, ex, ey, toPlayerRotate(ex, ey))

  end

  function enemy:draw()
    local sprX, sprY = self.physics.body:getPosition()

    -- Draw the body
    sprW = self.sprite:getWidth()
    sprH = self.sprite:getHeight()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(self.sprite, sprX, sprY, self.rotate, 1, 1, sprW/2, sprH/2+6)
  end

  return enemy

end

return fishInit
