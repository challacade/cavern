local function spikeInit(enemy, x, y, arg)

  -- Initialize physics
  enemy.physics = world:newBSGRectangleCollider(x, y + 12, 114, 114, 34)
  enemy.physics:setCollisionClass('Enemy')
  enemy.physics:setType('static')
  enemy.physics:setFixedRotation(true)
  -- We need this to access the table itself given the physics
  enemy.physics.parent = enemy

  -- Properties
  enemy.health = 10
  enemy.hitPower = 2
  enemy.barY = 90
  enemy.groundDir = arg
  enemy.id = math.random()

  enemy.moveTotalTime = 2
  enemy.moveTimer = 1
  enemy.moveDir = -1
  enemy.speed = 148

  enemy.state = -1
  enemy.stateTimer = math.random(0.5, 2.5)

  enemy.sprite = sprites.enemies.spikeBody
  enemy.scaleX = 1
  enemy.scaleY = 1
  enemy.scaleTween = nil

  function enemy:update(dt)

    self.moveTimer = updateTimer(self.moveTimer, dt)
    self.stateTimer = updateTimer(self.stateTimer, dt)

    -- State -1: right after spawning, random pause before moving
    if self.state == -1 and self.stateTimer == 0 then
      self.state = 0
      self.moveTimer = self.moveTotalTime
    end

    if self.moveTimer == 0 and self.state < 1 then
      self.moveDir = self.moveDir * -1
      self.stateTimer = 1
      self.state = 1 -- prepping for spikes
    end

    -- State 0 and 0.5: Moving slowly, not really doing anything
    if self.state == 0 or self.state == 0.5 then
      if self.groundDir == "up" or self.groundDir == "down" then
        self.physics:setX(self.physics:getX() + (self.moveDir * dt * self.speed))
      else
        self.physics:setY(self.physics:getY() + (self.moveDir * dt * self.speed))
      end


      -- Movement animation (flattening and unflattening)

      if self.state == 0 then
        if self.scaleTween == nil then
    			self.scaleTween = flux.to(self, self.moveTotalTime/6, {scaleX = 1.3, scaleY = 0.7})
    		end
        self.state = 0.5
    		--if self.jump_tween_y == nil then
    			--self.jump_tween_y = flux.to(self, 0.5, {y = y - 176}):oncomplete(on_y_complete):ease("quadout")
    		--end
      end

      if self.state == 0.5 then
        if self.scaleX == 1.3 then
          self.scaleTween = flux.to(self, self.moveTotalTime/6, {scaleX = 1, scaleY = 1})
        end
        if self.scaleX == 1 then
          self.state = 0
          self.scaleTween = nil
        end
      end

    end

    -- State 1: Freezing after moving, spawn spikes after timer
    if self.state == 1 and self.stateTimer == 0 then

      self.scaleTween = nil
      self.scaleX = 1
      self.scaleY = 1

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
      self.moveTimer = self.moveTotalTime
    end

  end

  function enemy:draw()
    local sprX, sprY = self.physics.body:getPosition()

    -- Draw the body
    sprW = self.sprite:getWidth()
    sprH = self.sprite:getHeight()
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.draw(self.sprite, sprX, sprY+sprH/2, nil, self.scaleX, self.scaleY, sprW/2, sprH)

    -- Get info to determine rotation value for the eye
    local dir = toPlayerVector(sprX, sprY)
    local vx, vy = dir:normalized():unpack()
    local rotate = math.atan2(vy, vx)

    -- Draw the eye
    sprW = sprites.enemies.flyerEye:getWidth()
    sprH = sprites.enemies.flyerEye:getHeight()
    love.graphics.draw(sprites.enemies.flyerEye, sprX, sprY - 7 + ((1 - self.scaleY) * sprH * 2), rotate, 1.15, 1.15, sprW/2, sprH/2)

  end

  return enemy

end

return spikeInit
