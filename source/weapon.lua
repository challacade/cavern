-- Stores all weapon objects
weapons = {}

-- Spawns an individual weapon and puts it in the weapons table
function spawnWeapon(x, y)

  -- New weapon being spawned
  local weapon = {}
  weapon.type = player.weapon
  weapon.dead = false

  -- Checks which weapon is being spawned and sets appropriate properties
  if weapon.type == 1 then
    weapon.physics = world:newCircleCollider(x, y, 20)
    weapon.physics:setCollisionClass('P_Weapon')
    weapon.power = 4
    weapon.speed = 4000
  elseif weapon.type == 2 then
    weapon.physics = world:newCircleCollider(x, y, 30)
    weapon.physics:setCollisionClass('P_Weapon')
    weapon.power = 22
    weapon.speed = 8000
  end

  local dir = toPlayerVector()
  dir = dir * weapon.speed
  weapon.physics:applyLinearImpulse(dir:unpack())

  -- Rocket Launcher kickback
  if weapon.type == 2 then
    player.physics:applyLinearImpulse((dir * -3):unpack())
  end

  table.insert(weapons, weapon)
end

function weapons:update(dt)

  -- Iterate through all weapons
  for i, w in ipairs(weapons) do

    -- When the weapon collides with a wall
    if w.physics:enter('Wall') then
      w.physics:destroy()
      w.dead = true
    end

    -- When the weapon collides with an enemy
    if w.physics:enter('Enemy') then
      local e = w.physics:getEnterCollisionData('Enemy')
      e.collider.parent.health = e.collider.parent.health - w.power

      w.physics:destroy()
      w.dead = true
    end

  end

  -- Iterate through all weapons in reverse to remove dead weapons from table
  for i=#weapons,1,-1 do
    if weapons[i].dead then
      table.remove(weapons, i)
    end
  end

end
