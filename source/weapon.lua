-- Stores all weapon objects
weapons = {}

-- Spawns an individual weapon and puts it in the weapons table
function spawnWeapon(x, y)

  -- New weapon being spawned
  local weapon = {}
  weapon.id = math.random()
  weapon.type = player.weapon
  weapon.dead = false
  weapon.onDestroy = nil
  weapon.draw = nil
  weapon.sprite = nil

  -- offset the weapon, to more accurately come from the barrel
  -- y = y + 4

  -- Direction the weapon will travel
  weapon.dir = vector(1, 0):rotateInplace(player.armAngle)

  -- Checks which weapon is being spawned and sets appropriate properties
  if weapon.type == 1 then

    -- Sets x and y to the player's shoulder
    x = x + (player.facing * -22)
    y = y - 12

    -- offset (in pixels) outside the center of the player
    local offdir = weapon.dir * 124
    local ox, oy = offdir:unpack()
    weapon.physics = world:newCircleCollider(x + ox, y + oy, 12)
    weapon.power = 4
    weapon.speed = 4000

    spawnBlast(weapon.physics.body:getX(), weapon.physics.body:getY(), 50,
      {1, 0, 0}, 0.2)

    -- This weapon has a trail, which is spawned here
    spawnTrail(weapon.id, 3, 8, {1, 0, 0, 0.706})

    -- Player laser sound effect
    soundManager:play("laser")

  elseif weapon.type == 2 then

    -- Sets x and y to the player's shoulder
    x = x + (player.facing * -22)
    y = y - 30

    local offsetVec = weapon.dir * 168
    local wx, wy = offsetVec:unpack()

    weapon.physics = world:newCircleCollider(x + wx, y + wy, 21)
    weapon.power = 0
    weapon.speed = 4000
    weapon.sprite = sprites.player.bomb

    weapon.draw = function(wep)
      local wx, wy = wep.physics:getPosition()
      love.graphics.setColor(1, 1, 1, 1)
      love.graphics.draw(wep.sprite, wx, wy, nil, 1, 1, wep.sprite:getWidth()/2, wep.sprite:getHeight()/2)
    end

    soundManager:play("bombShot")

  elseif weapon.type == 3 then

    -- Sets x and y to the player's shoulder
    x = x + (player.facing * -12)
    y = y - 24

    local offsetVec = weapon.dir * 126
    local wx, wy = offsetVec:unpack()

    local width = 80
    local height = 40
    local angle = math.atan2(wy, wx)

    -- Leave the player's hand on the spear before going to bare spear sprite
    weapon.handTimer = 0 -- set to >0 to re-enable this feature
    weapon.sprite = sprites.player.armSpear

    weapon.physics = world:newRectangleCollider(x + wx - width/2,
      y + wy - height/2, width, height)
    weapon.physics:setAngle(angle)
    weapon.power = 12
    weapon.speed = 12000

    weapon.draw = function(wep)
      local wx, wy = wep.physics:getPosition()
      love.graphics.setColor(1, 1, 1, 1)
      love.graphics.draw(wep.sprite, wx, wy, angle, 1, 1, wep.sprite:getWidth()-40, wep.sprite:getHeight()/2)
    end

    soundManager:play("spear")
  end

  -- Set the weapon's collision class
  weapon.physics:setCollisionClass('P_Weapon')
  weapon.physics.parent = weapon

  -- Store x and y value of physics for some "onDestroy" functions
  weapon.x = x
  weapon.y = y

  weapon.dir = weapon.dir * weapon.speed
  weapon.physics:applyLinearImpulse(weapon.dir:unpack())

  -- Rocket Launcher kickback
  if weapon.type == 2 then
    player.physics:applyLinearImpulse((weapon.dir * -6):unpack())
  end

  table.insert(weapons, weapon)
end

function weapons:update(dt)

  -- Iterate through all weapons
  for i, w in ipairs(weapons) do

    -- Update table x and y for onDestroy functions
    w.x, w.y = w.physics:getPosition()

    -- Spawn the smoke (for Rocket Launcher)
    if w.type == 2 then
      fires:spawnFire(w.x, w.y, 0.5, vector(0, 0), 3, nil, nil, true)
    end

    -- Update the hand timer (for spears)
    if w.type == 3 then
      w.handTimer = updateTimer(w.handTimer, dt)
      if w.handTimer <= 0 then
        w.sprite = sprites.player.spear
      end
    end

    -- When the weapon collides with a wall
    if w.physics:enter('Wall') or w.physics:enter('Transition') then
      w.physics:destroy()
      w.dead = true
    end

    -- When a rocket collides with the surface of water
    if w.type == 2 and w.physics:enter('Water') then
      w.physics:destroy()
      w.dead = true
    end

    -- When the weapon collides with an enemy
    if w.physics:enter('Enemy') then
      local e = w.physics:getEnterCollisionData('Enemy')
      e.collider.parent:damage(w.power)

      w.physics:destroy()
      w.dead = true
    end

    -- Updates the weapon's trail (if it has one)
    if w.dead ~= true then
      for _,t in ipairs(trails) do
        if t.id == w.id then
          t:update(dt, w)
        end
      end
    end

  end

  -- Iterate through all weapons in reverse to remove dead weapons from table
  for i=#weapons,1,-1 do
    if weapons[i].dead then

      -- If weapon is a laser, break into debris
      if weapons[i].type == 1 then
          local x = weapons[i].x
          local y = weapons[i].y
          spawnParticle(x, y, "laserDebris", vector(-15, -50))
          spawnParticle(x, y, "laserDebris", vector(15, -50))
          spawnParticle(x, y, "laserDebris", vector(-35, -25))
          spawnParticle(x, y, "laserDebris", vector(35, -25))
          spawnParticle(x, y, "laserDebris", vector(-15, 0))
          spawnParticle(x, y, "laserDebris", vector(15, 0))
      end

      -- If weapon is a rocket, explode
      if weapons[i].type == 2 then
        explode(weapons[i].x, weapons[i].y)
      end

      table.remove(weapons, i)

    end
  end

end

function weapons:draw()
  for _,w in ipairs(self) do
    if w.draw ~= nil then
      w.draw(w)
    end
  end
end
