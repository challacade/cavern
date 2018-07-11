local function bossInit(enemy, x, y, arg)

  -- Initialize physics
  enemy.physics = world:newBSGRectangleCollider(x, y, 256, 256, 82)
  enemy.physics:setCollisionClass('Enemy')
  enemy.physics:setType('static')
  enemy.physics:setFixedRotation(true)
  -- We need this to access the table itself given the physics
  enemy.physics.parent = enemy

  -- Properties
  enemy.health = 300
  enemy.hitPower = 12
  enemy.moveForce = 11000
  enemy.maxSpeed = 400
  enemy.barY = 1000 -- Putting the health bar above the screen
  
  -- Shake logic
  local ex, ey = enemy.physics:getPosition()
  enemy.baseY = ey -- Default Y position (since the boss will move)
  enemy.distY = 10 -- How far the boss deviates from the Y position
  enemy.shakeDir = 1 -- 1 for down, -1 for up

  -- Sprite info
  enemy.sprite = sprites.enemies.bossBody

  -- Eyes
  enemy.eye = spawnEye(ex, ey, 0, 1, sprites.enemies.bigBossEye)
  
  -- State
  enemy.state = 1
  enemy.stateTimer = 1
  enemy.stateCounter = 0

  function enemy:update(dt)
    
    self.stateTimer = updateTimer(self.stateTimer, dt)

    local ex, ey = self.physics:getPosition()
    self.eye:update(dt, ex, ey, toPlayerRotate(ex, ey))
    
    -- Breathing/Shaking
    -- The boss bobs up and down either slowly or quickly
    local bobSpeed = 8
    self.physics:setY(ey + (self.shakeDir * bobSpeed * dt))
    
    -- If the boss moves too far past its base position,
    -- change the direction
    if math.abs(self.baseY - self.physics:getY()) > self.distY then
      self.shakeDir = self.shakeDir * -1
    end

    -- State 0: Boss Intro (eyes opening)
    if self.state == 0 then
      
    end
    
    -- State 1: Lasers
    if self.state == 1 then
      
      -- When the timer is up
      if self.stateTimer <= 0 then
        
        -- ...and the counter is even, spawn a reverse blast
        -- indicating that a laser is about to be shot
        if self.stateCounter % 2 == 0 then
          spawnBlast(ex, ey, 1400, {1, 0, 0}, 1.5, true)
          self.stateTimer = 1.5
        else
          -- ...otherwise, shoot a laser
          spawnEnemyProj(ex, ey, toPlayerVector(ex, ey), "bossLaser")
          spawnBlast(ex, ey, 2200, {1, 0, 0}, 0.75)
          self.stateTimer = 3
        end
        
        -- increase the counter
        self.stateCounter = self.stateCounter + 1
        
      end
      
    end

    -- REMOVE THIS AFTER BOSS IS DONE!!!
    blackScreen.alpha = 0
  end

  function enemy:draw()
    local sprX, sprY = self.physics.body:getPosition()

    -- Draw the body of the boss
    sprW = self.sprite:getWidth()
    sprH = self.sprite:getHeight()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(self.sprite, sprX, sprY, nil, 1, 1, sprW/2, sprH/1.4)
  end

  return enemy

end

return bossInit
