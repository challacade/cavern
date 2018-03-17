player = {}

player.state = 1  -- 0 (cutscene), 1 (free to move)

player.width = 96
player.height = 192

player.physics = world:newBSGRectangleCollider(2500, 500, player.width,
  player.height, 22)
player.physics:setCollisionClass('Player')
player.physics:setLinearDamping(2)
player.physics:setFixedRotation(true)
player.moveForce = 40000
player.maxSpeed = 400

player.health = 10
player.damaged = 0 -- timer for the damage flash

player.weapon = 0 -- 0 (none), 1 (blaster), 2 (rocket), 3 (harpoon)
player.shotCooldown = 0 -- timer for pause between weapon shots

player.submerged = false -- true if the player is underwater
player.facing = 1 -- 1 = right, -1 = left

function player:update(dt)

  -- Player movement

  -- speedFromVelocity is from global_functions.lua
  -- takes vx and vy from getLinearVelocity and applies Pythagorean Theorem
  local speed = speedFromVelocity( self.physics:getLinearVelocity() )

  -- only apply force to the player if he is moving slower than the max speed
  if speed < self.maxSpeed then

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

  -- Handle damage flash timer
  self.damaged = updateTimer(self.damaged, dt)

  -- Update shot cooldown timer
  self.shotCooldown = updateTimer(self.shotCooldown, dt)

  if love.mouse.isDown(1) and self.shotCooldown <= 0 then
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

end

-- Draw the player
function player:draw()

  love.graphics.setColor(255, 255, 255, 255)
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

  elseif player.weapon == 3 then

  end

  -- flip is used to decide if the sprite needs to flip vertically
  local flip = 1
  local mx, my = cam:mousePosition()
  if mx < px then
    flip = -1
  end

  local vx, vy = (toPlayerVector(mx, my)*-1):unpack()

  -- body uses player.facing to turn the correct direction (towards the mouse)
  love.graphics.draw(sprites.player.body, px, py+36, nil, player.facing, 1, 38, 60)
  -- helmet rotates towards the mouse, flips vertically if facing left
  love.graphics.draw(sprites.player.helmet, px, py-50, math.atan2(vy, vx), 1, flip, 50, 50)
  -- only rotate the arm if it has a weapon equipped
  if player.weapon == 0 then
    --love.graphics.draw(armSprite, px, py + moveDown, nil, player.facing, 1, ox, oy)
  else
    love.graphics.draw(armSprite, px, py + moveDown, math.atan2(vy, vx), 1, flip, ox, oy)
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
    self.shotCooldown = 0.35
  elseif self.weapon == 2 then -- Rocket
    self.shotCooldown = 3
  elseif self.weapon == 3 then -- Harpoon
    self.shotCooldown = 0.25
  end

  local px, py = self.physics:getPosition()
  spawnWeapon(px, py)
end

-- Cycle between each weapon
function player:swapWeapon()

  -- Order is Blaster, then Rocket, then Harpoon, then back to Blaster
  if player.weapon == 1 and gameState.pickups.rocket then
    player.weapon = 2
  elseif player.weapon == 2 and gameState.pickups.harpoon then
    player.weapon = 3
  elseif player.weapon == 3 then
    player.weapon = 1
  end

end

-- Player takes damage
function player:hurt(damage)
  if self.damaged == 0 then
    self.damaged = 1
    self.health = self.health - damage
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
