player = {}

player.physics = world:newBSGRectangleCollider(3000, 500, 96, 192, 22)
player.physics:setCollisionClass('Player')
player.physics:setLinearDamping(2)
player.physics:setFixedRotation(true)
player.moveForce = 40000
player.maxSpeed = 400

player.health = 10
player.damaged = 0 -- timer for the damage flash

player.weapon = 1 -- 0 (none), 1 (blaster), 2 (missile), 3 (harpoon)
player.shotCooldown = 0 -- timer for pause between weapon shots


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

end

-- Player shoots his equipped weapon
function player:shoot()
  self.shotCooldown = 0 -- amount of time (in seconds) between each shot

  if self.weapon == 1 then -- Blaster
    self.shotCooldown = 0.35
  elseif self.weapon == 2 then -- Missile
    self.shotCooldown = 3
  elseif self.weapon == 3 then -- Harpoon
    self.shotCooldown = 1.5
  end

  local px, py = self.physics:getPosition()
  spawnWeapon(px, py)
end

-- Cycle between each weapon
function player:swapWeapon()

  -- Order is Blaster, then Missile, then Harpoon, then back to Blaster
  if player.weapon == 1 and gameState.pickups.missile then
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
