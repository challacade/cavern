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

  weapon.dir = toPlayerVector()

  -- offset the weapon, to more accurately come from the barrel
  y = y + 14

  -- Checks which weapon is being spawned and sets appropriate properties
  if weapon.type == 1 then

    -- offset (in pixels) outside the center of the player
    local offdir = weapon.dir * 86
    local ox, oy = offdir:unpack()
    weapon.physics = world:newCircleCollider(x + ox, y + oy, 16)
    weapon.power = 4
    weapon.speed = 4000

    spawnBlast(weapon.physics.body:getX(), weapon.physics.body:getY(), 50,
      {255, 0, 0}, 0.2)

    -- This weapon has a trail, which is spawned here
    spawnTrail(weapon.id, 5, 15, {255, 0, 0, 180})

  elseif weapon.type == 2 then

    weapon.physics = world:newCircleCollider(x, y, 30)
    weapon.power = 22
    weapon.speed = 8000

  elseif weapon.type == 3 then

    local offsetVec = weapon.dir * 140
    local wx, wy = offsetVec:unpack()

    local width = 80
    local height = 40

    weapon.physics = world:newRectangleCollider(x + wx - width/2,
      y + wy - height/2, width, height)
    weapon.physics:setAngle(math.atan2(wy, wx))
    weapon.power = 14
    weapon.speed = 12000
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
    player.physics:applyLinearImpulse((weapon.dir * -3):unpack())
  end

  table.insert(weapons, weapon)
end

function weapons:update(dt)

  -- Iterate through all weapons
  for i, w in ipairs(weapons) do

    -- Update table x and y for onDestroy functions
    w.x, w.y = w.physics:getPosition()

    -- When the weapon collides with a wall
    if w.physics:enter('Wall') then
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
