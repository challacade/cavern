local function spikeInit(enemy, x, y, arg)

  -- Initialize physics
  -- Spike enemies on the ground (down) need a slight offset
  local offY = 0
  if arg == "down" then
    offY = 12
  end
  enemy.physics = world:newBSGRectangleCollider(x + 8, y + 8 + offY, 102, 102, 34)
  enemy.physics:setCollisionClass('Enemy')
  enemy.physics:setType('static')
  enemy.physics:setFixedRotation(true)
  -- We need this to access the table itself given the physics
  enemy.physics.parent = enemy

  -- Properties
  enemy.health = 12
  enemy.hitPower = 5
  enemy.barY = 90
  enemy.groundDir = arg
  enemy.id = math.random()

  -- Bar should be below the enemy if upside-down
  if arg == "up" then
    enemy.barY = -80
  end

  enemy.moveTotalTime = 2
  enemy.moveTimer = 1
  enemy.moveDir = -1
  enemy.speed = 148

  enemy.state = -1
  enemy.stateTimer = math.random()

  enemy.sprite = sprites.enemies.spikeBody
  enemy.scaleX = 1
  enemy.scaleY = 1
  enemy.scaleTween = nil

  enemy.eye = spawnEye(x, y, 0, 1.15, sprites.enemies.flyerEye)

  function enemy:getRotationInfo()

    local rotate = 0
    local rotVec = vector(0, 1)
    if self.groundDir == "left" then
      rotate = math.pi/2
      rotVec = vector(-1, 0)
    elseif self.groundDir == "up" then
      rotate = math.pi
      rotVec = vector(0, -1)
    elseif self.groundDir == "right" then
      rotate = math.pi/-2
      rotVec = vector(1, 0)
    end

    return rotate, rotVec

  end

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
      self.stateTimer = 0.3
      self.state = 1 -- prepping for spikes

      self.scaleTween = nil
      self.scaleX = 1
      self.scaleY = 1
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


    -- Start inflating

    local inflateScale = 1.4

    if self.state == 1 and self.stateTimer == 0 then
      if self:inSight() then
        self.scaleTween = flux.to(self, 0.8, {scaleX = inflateScale, scaleY = inflateScale}):ease("cubicinout")
        self.state = 1.1
      else
        self.state = 2
        self.stateTimer = 0.8
      end
    end

    -- Wait until finished inflating
    if self.state == 1.1 and self.scaleX == inflateScale then
      self.scaleTween = flux.to(self, 0.6, {scaleX = 1, scaleY = 1}):ease("backout")
      self.state = 1.2
      self.stateTimer = 0.1
    end

    if self.state == 1.2 and self.stateTimer == 0 then
      local ex, ey = self.physics:getPosition()
      spawnSpike(ex, ey, 1, self.id, self.groundDir)
      spawnSpike(ex, ey, 2, self.id, self.groundDir)
      spawnSpike(ex, ey, 3, self.id, self.groundDir)
      spawnSpike(ex, ey, 4, self.id, self.groundDir)
      spawnSpike(ex, ey, 5, self.id, self.groundDir)
      soundManager:play("spikes")

      self.scaleTween = nil
      self.stateTimer = 1
      self.state = 2
    end

    -- State 2: Wait until timer, then go back to state 0
    if self.state == 2 and self.stateTimer == 0 then
      self.state = 0
      self.moveTimer = self.moveTotalTime
    end


    -- Update the Eye
    -- Get info to determine rotation value for the eye
    local ex, ey = self.physics:getPosition()

    -- Draw the eye
    local sprW = self.eye.spr:getWidth()
    local sprH = self.eye.spr:getHeight()
    local rotate, rotVec = self:getRotationInfo()
    local vx, vy = rotVec:unpack()
    self.eye:update(dt, ex + (vx * (-2 + ((1 - self.scaleY) * sprH * 2))), ey + (vy * (-7 + ((1 - self.scaleY) * sprH * 2))), toPlayerRotate(ex, ey))

  end

  function enemy:draw()

    local sprX, sprY = self.physics.body:getPosition()
    local rotate, rotVec = self:getRotationInfo()

    -- Draw the body
    sprW = self.sprite:getWidth()
    sprH = self.sprite:getHeight()

    -- Info for the origin location
    local vx, vy = rotVec:unpack()

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(self.sprite, sprX+(vx*sprW/2), sprY+(vy*sprH/2), rotate, self.scaleX, self.scaleY, sprW/2, sprH)

  end

  return enemy

end

return spikeInit
