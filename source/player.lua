player = {}

player.state = 1  -- 0 (cutscene), 1 (free to move)

player.width = 96
player.height = 192

player.physics = world:newBSGRectangleCollider(1200, 1000, player.width,
  player.height, 22)
player.physics:setCollisionClass('Player')
player.physics:setLinearDamping(2)
player.physics:setFixedRotation(true)
player.moveForce = 40000
player.maxSpeed = 400

player.health = gameState.player.maxHealth
player.damaged = 0 -- timer for the damage flash
player.faded = -1 -- determines if player is translucent for damage flash
player.fadedTimer = 0 -- timer for flipping faded status

player.weapon = 0 -- 0 (none), 1 (blaster), 2 (rocket), 3 (harpoon)
player.shotCooldown = 0 -- timer for pause between weapon shots

player.submerged = false -- true if the player is underwater
player.facing = 1 -- 1 = right, -1 = left

player.jetpackTimer = 0
player.stateTimer = 0

function player:update(dt)

  -- Player movement

  -- speedFromVelocity is from global_functions.lua
  -- takes vx and vy from getLinearVelocity and applies Pythagorean Theorem
  local speed = speedFromVelocity( self.physics:getLinearVelocity() )

  -- only apply force to the player if he is moving slower than the max speed
  if speed < self.maxSpeed and self.state == 1 then

    if love.keyboard.isDown("down") or love.keyboard.isDown("s") then
      self.physics:applyForce(0, self.moveForce)
    end
    if love.keyboard.isDown("up") or love.keyboard.isDown("w") then
      self.physics:applyForce(0, -1 * self.moveForce)
    end
    if love.keyboard.isDown("left") or love.keyboard.isDown("a") then
      self.physics:applyForce(-1 * self.moveForce, 0)
    end
    if love.keyboard.isDown("right") or love.keyboard.isDown("d") then
      self.physics:applyForce(self.moveForce, 0)
    end

  end

  -- State timer
  self.stateTimer = updateTimer(self.stateTimer, dt)

  -- Handle damage flash timers
  self.damaged = updateTimer(self.damaged, dt)
  self.fadedTimer = updateTimer(self.fadedTimer, dt)

  -- Update shot cooldown timer
  self.shotCooldown = updateTimer(self.shotCooldown, dt)

  if love.mouse.isDown(1) and self.shotCooldown <= 0 and self.state == 1 then
    player:shoot()
  end

  -- Handles all collisions for the player
  player:collisions(dt)

  -- This section handles the player interacting with Water
  local px, py = self.physics:getPosition()
  local waters = world:queryCircleArea(px, py, 40, {'Water'})
  local ripples = world:queryCircleArea(px, py, 40, {'Ripple'})
  if #ripples > 0 and #waters == 0 then
    player.submerged = false
  elseif #ripples > 0 and #waters > 0 then
    player.submerged = true
  end

  -- "facing" is used for drawing the player sprites
  -- flip to the side of the player the mouse is at
  local mx, my = cam:mousePosition()
  if mx < px then
    player.facing = -1
  else
    player.facing = 1
  end

  if player.damaged > 0 then
    if player.fadedTimer <= 0 then
      player.fadedTimer = 0.04
      player.faded = player.faded * -1
    end
  else
    player.faded = 1
  end

  -- Update jetpack timer (for spawning fire particles)
  self.jetpackTimer = updateTimer(self.jetpackTimer, dt)

  if self.jetpackTimer <= 0 and player.submerged == false then
    fires:spawnFire(px + (self.facing * -44), py + 50, 0.2, vector(0, 1))
  end

  -- Player death
  if player.health <= 0 and player.state > 0 then

    local px, py = player.physics:getPosition()

    player.state = -1 -- freeze the player
    spawnBlast(px, py, 600, {0.5, 0.5, 0.5}, 1)

    -- When the player dies, he doesn't get destroyed, he is just moved outside
    -- the room where he can't be seen.
    player.physics:setPosition(px, -300)

    -- When this timer hits zero, start the fadeout
    player.stateTimer = 2

  end

  -- Player has died, need to fadeout the screen
  if self.stateTimer < 0 and self.state == -1 then
    blackScreen:fadeOut(1)
    self.stateTimer = 1.5
    self.state = -2
  end

  -- Fadeout completed, load the save file
  if self.stateTimer < 0 and self.state == -2 then
    loadGame()
  end

end

-- Draw the player
function player:draw()

  if player.faded == -1 then
    love.graphics.setColor(1, 1, 1, 0.784) -- damage flash
  else
    love.graphics.setColor(1, 1, 1, 1)
  end

  local px, py = self.physics:getPosition()

  -- Determine arm data
  local armSprite = sprites.player.armEmpty -- sprite to draw for the arm
  local moveDown = 14
  local ox = 18 -- offset x
  local oy = 18 -- offset y

  if player.weapon == 1 then
    armSprite = sprites.player.armBlaster
    ox = 18
    oy = 27
  elseif player.weapon == 2 then
    armSprite = sprites.player.rocketLauncher
    ox = sprites.player.rocketLauncher:getWidth()/2 - 20
    oy = sprites.player.rocketLauncher:getHeight()/2
    moveDown = 22
  elseif player.weapon == 3 then
    armSprite = sprites.player.armSpear
    ox = sprites.player.rocketLauncher:getWidth()/2
    oy = sprites.player.rocketLauncher:getHeight()/2
    moveDown = 23
  end

  -- flip is used to decide if the sprite needs to flip vertically
  local flip = 1
  local mx, my = cam:mousePosition()
  if mx < px then
    flip = -1
  end

  local vx, vy = (toPlayerVector(mx, my)*-1):unpack()
  local armAngle = math.atan2(vy, vx) -- angle that the arm will rotate
  local headAngle = armAngle          -- angle that the head will rotate

  -- Don't want head looking straight up or straight down, want to limit
  -- this angle
  if flip == 1 then
    if headAngle < -0.8 then
      headAngle = -0.8
    elseif headAngle > 0.65 then
      headAngle = 0.65
    end
  else
    if headAngle < 0 and headAngle > -2.4 then
      headAngle = -2.4
    elseif headAngle > 0 and headAngle < 2.6 then
      headAngle = 2.6
    end
  end

  -- Jetpack data
  local jetSprite = sprites.player.jetpack
  if gameState.pickups.aquaPack then
    jetSprite = sprites.player.aquaPack
  end

  -- draw jetpack first
  love.graphics.draw(jetSprite, px + (player.facing * -22), py + 18, nil, player.facing, 1, 38, 60)
  -- body uses player.facing to turn the correct direction (towards the mouse)
  love.graphics.draw(sprites.player.body, px, py+36, nil, player.facing, 1, 38, 60)
  -- helmet rotates towards the mouse, flips vertically if facing left
  love.graphics.draw(sprites.player.helmet, px, py-50, headAngle, 1, flip, 50, 50)
  -- only rotate the arm if it has a weapon equipped
  if player.weapon == 0 then
    --love.graphics.draw(armSprite, px, py + moveDown, nil, player.facing, 1, ox, oy)
  else
    if player.weapon ~= 3 or (self.shotCooldown <= 0) then
      love.graphics.draw(armSprite, px, py + moveDown, armAngle, 1, flip, ox, oy)
    end
  end

end

-- Player shoots his equipped weapon
function player:shoot()
  -- Don't spawn anything if the player doesn't have a weapon
  if player.weapon == 0 then
    return nil
  end

  -- Can't shoot the blaster or rocket launcher if underwater
  if (player.weapon == 1 or player.weapon == 2) and player.submerged then
    -- put an "error" sound effect here
    return nil
  end

  self.shotCooldown = 0 -- amount of time (in seconds) between each shot

  if self.weapon == 1 then -- Blaster
    self.shotCooldown = 0.5
  elseif self.weapon == 2 then -- Rocket
    self.shotCooldown = 3
  elseif self.weapon == 3 then -- Harpoon
    self.shotCooldown = 1
  end

  local px, py = self.physics:getPosition()
  spawnWeapon(px, py)
end

-- Cycle between each weapon
function player:swapWeapon()

  -- Order is Blaster, then Rocket, then Harpoon, then back to Blaster
  if player.weapon == 1 and gameState.pickups.rocket then
    player.weapon = 2
  elseif player.weapon == 2 then
    if gameState.pickups.harpoon then
      player.weapon = 3
    else
      player.weapon = 1
    end
  elseif player.weapon == 3 then
    player.weapon = 1
  end

end

-- Player takes damage
function player:hurt(damage)
  if self.damaged == 0 then
    self.damaged = 1
    self.health = self.health - damage
    damages:spawnDamage(self.physics:getX(), self.physics:getY(), damage)
    shake:start(0.05, 6, 0.01, 0.3)
  end
end

-- Called in player:update, handles all collisions
function player:collisions(dt)

  if self.physics:enter('Transition') then
    local t = self.physics:getEnterCollisionData('Transition')
    -- Change to the map (stored in the transition's name), and pass t.collider
    -- Note: t.collider is just the transition object
    changeToMap(t.collider.toMap, t.collider)
  end

end
