-- Stores all weapon objects
weapons = {}

-- Spawns an individual weapon and puts it in the weapons table
function spawnWeapon(x, y)

  -- New weapon being spawned
  local weapon = {}
  weapon.type = player.weapon
  weapon.dead = false
  weapon.onDestroy = nil

  weapon.dir = toPlayerVector()

  -- Checks which weapon is being spawned and sets appropriate properties
  if weapon.type == 1 then
    weapon.physics = world:newCircleCollider(x, y, 20)
    weapon.power = 4
    weapon.speed = 4000
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

  -- Store x and y value of physics for some "onDestroy" functions
  weapon.x = x
  weapon.y = y

  weapon.dir = weapon.dir * weapon.speed
  weapon.physics:applyLinearImpulse(weapon.dir:unpack())

  -- Rocket Launcher kickback
  if weapon.type == 2 then
    player.physics:applyLinearImpulse((dir * -3):unpack())
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

  end

  -- Iterate through all weapons in reverse to remove dead weapons from table
  for i=#weapons,1,-1 do
    if weapons[i].dead then

      -- If weapon is a rocket, explode
      if weapons[i].type == 2 then
        explode(weapons[i].x, weapons[i].y)
      end

      table.remove(weapons, i)

    end
  end

end
