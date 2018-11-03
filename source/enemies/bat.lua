local function batInit(enemy, x, y, arg)

  -- Initialize physics
  enemy.physics = world:newBSGRectangleCollider(x, y, 92, 92, 25)
  enemy.physics:setCollisionClass('Enemy')
  enemy.physics:setLinearDamping(2)
  enemy.physics:setFixedRotation(true)
  -- We need this to access the table itself given the physics
  enemy.physics.parent = enemy

  -- Properties
  enemy.health = 12
  enemy.hitPower = 5
  enemy.moveForce = 17000
  enemy.maxSpeed = 800
  enemy.barY = 62

  -- Sprite info
  enemy.sprite = sprites.enemies.flyerBody
  enemy.wingSprite = sprites.enemies.flyerWing1
  enemy.spriteTimerBase = 0.001
  enemy.spriteTimer = enemy.spriteTimerBase

  enemy.eye = spawnEye(x, y, 0, 1, sprites.enemies.flyerEye)

  -- Final boss can spawn these, and they shoot down
  -- if arg is true
  if arg then
    enemy.physics:applyLinearImpulse(0, 20000)
  end

  function enemy:update(dt)

    if self:inSight() then
      local speed = speedFromVelocity( self.physics:getLinearVelocity() )
      if speed < self.maxSpeed then
        local ex, ey = self.physics:getPosition()
        local dir = toPlayerVector(ex, ey)
        dir = dir * self.moveForce
        self.physics:applyForce(dir:unpack())
      end
    end

    -- Update the animation; alternate between the two frames
    self.spriteTimer = updateTimer(self.spriteTimer, dt)
    if self.spriteTimer == 0 then
      if self.wingSprite == sprites.enemies.flyerWing1 then
        self.wingSprite = sprites.enemies.flyerWing2
      else
        self.wingSprite = sprites.enemies.flyerWing1
      end
      self.spriteTimer = self.spriteTimerBase
    end

    -- Update the eye of the flyer
    -- Not to be confused with the Eye of the Tiger
    local ex, ey = self.physics:getPosition()
    local dir = toPlayerVector(ex, ey)
    local offX, offY = (dir * 16):unpack()
    self.eye:update(dt, ex + offX, ey + offY, toPlayerRotate(ex, ey))
  end

  function enemy:draw()
    local sprW = self.wingSprite:getWidth()
    local sprH = self.wingSprite:getHeight()
    local sprX, sprY = self.physics.body:getPosition()

    local wingOffset = -24
    if self.wingSprite == sprites.enemies.flyerWing2 then
      wingOffset = wingOffset + 5
    end

    -- Draw the wings first
    love.graphics.setColor(1, 1, 1, 0.314)
    love.graphics.draw(self.wingSprite, sprX, sprY + wingOffset, nil, 1, 1, sprW/2, sprH/2)

    -- Draw the body of the flyer (rotates towards player)
    sprW = self.sprite:getWidth()
    sprH = self.sprite:getHeight()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(self.sprite, sprX, sprY, toPlayerRotate(sprX, sprY), 1, 1, sprW/2, sprH/2)
  end

  return enemy

end

return batInit
