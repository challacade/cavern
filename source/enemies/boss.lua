local function bossInit(enemy, x, y, arg)

  -- Initialize physics
  enemy.physics = world:newBSGRectangleCollider(x, y, 256, 256, 82)
  enemy.physics:setCollisionClass('Enemy')
  enemy.physics:setType('static')
  enemy.physics:setFixedRotation(true)
  -- We need this to access the table itself given the physics
  enemy.physics.parent = enemy

  -- Properties
  enemy.maxHealth = 400
  enemy.health = enemy.maxHealth
  enemy.hitPower = 12
  enemy.moveForce = 11000
  enemy.maxSpeed = 400
  enemy.barY = 1000 -- Putting the health bar above the screen
  enemy.barAlpha = 0 -- Initially invisible, health bar fades in

  -- Shake logic
  local ex, ey = enemy.physics:getPosition()
  enemy.baseY = ey -- Default Y position (since the boss will move)

  -- How far the boss deviates from the Y position
  enemy.shortDist = 10
  enemy.longDist = 16
  enemy.distY = enemy.shortDist

  -- Shake direction and speed
  enemy.shakeDir = 1 -- 1 for down, -1 for up
  enemy.fastShake = 180
  enemy.slowShake = 8
  enemy.shakeSpeed = enemy.slowShake

  -- Sprite info
  enemy.sprite = sprites.enemies.bossBody

  -- Eyes
  enemy.eyes = {}
  --enemy.eye = spawnEye(ex, ey, 0, 1, sprites.enemies.bigBossEye)

  for i=1, 14 do -- spawn 10 eyes

    local eye = {}

    eye.spr = sprites.enemies.bigBossEye
    eye.scale = 0.4

    -- These are the eye's position relative to the boss's physics
    eye.relX = 0
    eye.relY = 0

    if i == 1 then
      eye.relX = 0
      eye.relY = 0
      eye.scale = 1
    elseif i == 2 then
      eye.relX = 250
      eye.relY = -30
      eye.scale = 0.37
    elseif i == 3 then
      eye.relX = -250
      eye.relY = -30
      eye.scale = 0.37
    elseif i == 4 then
      eye.relX = 320
      eye.relY = -200
      eye.scale = 0.27
    elseif i == 5 then
      eye.relX = -320
      eye.relY = -200
      eye.scale = 0.27
    elseif i == 6 then
      eye.relX = 500
      eye.relY = -160
      eye.scale = 0.39
    elseif i == 7 then
      eye.relX = -500
      eye.relY = -160
      eye.scale = 0.39
    elseif i == 8 then
      eye.relX = 680
      eye.relY = -60
      eye.scale = 0.23
    elseif i == 9 then
      eye.relX = -680
      eye.relY = -60
      eye.scale = 0.23
    elseif i == 10 then
      eye.relX = 740
      eye.relY = -220
      eye.scale = 0.31
    elseif i == 11 then
      eye.relX = -740
      eye.relY = -220
      eye.scale = 0.31
    elseif i == 12 then
      eye.relX = 450
      eye.relY = 20
      eye.scale = 0.31
    elseif i == 13 then
      eye.relX = -450
      eye.relY = 20
      eye.scale = 0.31
    elseif i == 14 then
      eye.relX = -40
      eye.relY = -210
      eye.scale = 0.26
    end

    local eyeX = ex + eye.relX
    local eyeY = ey + eye.relY

    table.insert(enemy.eyes, spawnEye(eyeX, eyeY, 0, eye.scale, eye.spr, eye))

  end

  -- State
  enemy.state = 0
  enemy.stateTimer = 2.5
  enemy.stateCounter = 0

  function enemy:update(dt)

    self.stateTimer = updateTimer(self.stateTimer, dt)

    local ex, ey = self.physics:getPosition()

    -- Update eyes
    for _,e in ipairs(self.eyes) do
      local eyeX = ex + e.args.relX
      local eyeY = ey + e.args.relY
      e:update(dt, eyeX, eyeY, toPlayerRotate(eyeX, eyeY))
    end

    -- Breathing/Shaking
    -- The boss bobs up and down either slowly or quickly
    if self.dead == false then
      self.physics:setY(ey + (self.shakeDir * self.shakeSpeed * dt))
    end

    -- If the boss moves too far past its base position,
    -- change the direction
    if math.abs(self.baseY - self.physics:getY()) > self.distY then
      self.shakeDir = self.shakeDir * -1
    end

    -- State 0: Boss Intro (eyes opening)
    if self.state == 0 then

      player.state = 0

      if self.stateTimer <= 0 then
        blackScreen:fadeIn(5)
        self.stateTimer = 5
        self.state = 0.1
        soundManager:play("helloBoss")
      end

    end

    if self.state == 0.1 then

      if self.stateTimer <= 0 then
        self.state = 1
        self.stateTimer = 1
      end

    end

    -- State 1: Lasers
    if self.state == 1 then

      if player.state == 0 then
        player.state = 1
        soundManager:startMusic("boss")
        love.audio.stop(sounds.music.danger)
      end

      if self.barAlpha < 1 then
        self.barAlpha = self.barAlpha + dt
      end

      if self.barAlpha > 1 then
        self.barAlpha = 1
      end

      self:laserState(1)

    end

    -- State 2: Shake to spawn flyers
    if self.state == 2 then

      -- Start shaking
      if self.stateTimer == 0 and self.stateCounter == 0 then

        self.shakeSpeed = self.fastShake
        self.distY = self.shortDist
        self.stateTimer = 0.5
        self.stateCounter = self.stateCounter + 1

      end

      -- Spawn a flyer
      if self.stateTimer == 0 and self.stateCounter > 0 then

        self.stateTimer = 0.75
        self.stateCounter = self.stateCounter + 1

        -- Spawn flyers, randomly on each side of the boss
        local x = 448 + math.random(0, 640) -- left side
        if math.random() > 0.5 then
          x = x + 1024 -- move to the right side
        end

        spawnEnemy(x, 290, "bat", true)

      end

      local toSpawn = 2

      -- spawn an extra enemy if boss is below half health
      if self.health < self.maxHealth / 2 then
        toSpawn = toSpawn + 1
      end

      if self.stateCounter > toSpawn then
        self.state = 3
        self.stateCounter = 0
      end

    end

    -- State 3: Lasers
    if self.state == 3 then
      self.shakeSpeed = self.slowShake
      self.distY = self.shortDist
      self:laserState(2)
    end

    -- State 4: Return to state 2
    if self.state == 4 then
      self.state = 2
    end

    -- Test if boss is dead
    if self.dead and self.state < 10 then

      self.state = 10
      self.stateTimer = 3
      flash:fadeIn(1)
      self.physics:setY(self.baseY)
      self.stateCounter = 0

      -- Fade out the music
      soundManager:musicFade()

      -- Kill all other enemies besides the boss
      for _,e in ipairs(enemies) do
        if e.type ~= "boss" then
          e.health = 0
        end
      end

    end

    -- State 10: Boss has just died, flash
    if self.state == 10 then

      if self.barAlpha > 0 then
        self.barAlpha = self.barAlpha - dt
      end

      if self.barAlpha < 0 then
        self.barAlpha = 0
      end

      if self.stateTimer == 0 then
        shake:start(30, 10, 0.01, false, nil)
        self.state = 10.5
        self.stateTimer = 3
        soundManager:play("bossDie")
      end

    end

    local explodeTime = 0.5

    if self.state == 10.5 and self.stateTimer == 0 then
      self.stateTimer = 0.05
      self.state = 11
    end

    -- State 11: Boss moves offscreen while exploding
    if self.state == 11 then

      -- Move upwards
      local ex, ey = self.physics:getPosition()
      self.physics:setY(ey - (25 * dt))

      if self.stateTimer == 0 then
        local blastX = ex + math.random(-772, 772)
        local blastY = ey + math.random(-120, 120)
        spawnBlast(blastX, blastY, 500, {1, 0, 0}, 0.4)
        soundManager:play("bossExplode")

        self.stateTimer = explodeTime
      end

      if ey < 242 then
        if flash.alpha == 0 then
          flash:fadeOut(3)
        end
      end

      if flash.alpha == 1 then
        self.state = 11.5
        self.stateTimer = 2
      end

    end

    if self.state == 11.5 and self.stateTimer == 0 then
      flash:fadeIn(3)
      self.state = 12
      shake:start(2, 10, 0.01, true, nil)
      changeToMap("rmBossAfter")
    end

  end

  function enemy:laserState(totalShots)

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

      -- After shooting 3 lasers, move to a different state
      if self.stateCounter == totalShots * 2 then -- CHANGE TO 6
        self.state = self.state + 1
        self.stateCounter = 0
        self.stateTimer = 2
      end

    end

    debug = self.barAlpha

  end

  function enemy:draw()

    local sprX, sprY = self.physics.body:getPosition()

    -- Draw the body of the boss
    sprW = self.sprite:getWidth()
    sprH = self.sprite:getHeight()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(self.sprite, sprX, sprY, nil, 1, 1, sprW/2, sprH/1.4)

  end

  function enemy:bossBar()

    -- Draw the back of the healthbar (red)
    love.graphics.setColor(1, 0, 0, self.barAlpha)
    love.graphics.rectangle("fill", 262, 1550, 2036, 52)

    -- Draw the green part of the health bar
    local greenWidth = 2036 * (self.health / self.maxHealth)
    if greenWidth < 0 then
      greenWidth = 0
    end
    love.graphics.setColor(0, 1, 0, self.barAlpha)
    love.graphics.rectangle("fill", 262, 1550, greenWidth, 52)

    -- Draw the white outline
    love.graphics.setLineWidth(12)
    love.graphics.setColor(1, 1, 1, self.barAlpha)
    love.graphics.rectangle("line", 256, 1544, 2048, 64)

    -- Draw "BOSS"
    love.graphics.setFont(fonts.boss)
    love.graphics.printf("BOSS", 128, 1444, 2304, "center")

  end

  return enemy

end

return bossInit
