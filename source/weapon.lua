-- Stores all weapon objects
weapons = {}

-- Spawns an individual weapon and puts it in the weapons table
function spawnWeapon(x, y, type)

  -- New weapon being spawned
  local weapon = {}
  weapon.type = type
  weapon.dead = false

  -- Checks which weapon is being spawned and sets appropriate properties
  if type == "basic" then
    weapon.physics = world:newCircleCollider(x, y, 20)
    weapon.physics:setCollisionClass('P_Weapon')

    weapon.power = 4

    local speed = 4000
    local vx, vy = playerVector()
    weapon.physics:applyLinearImpulse(vx * speed, vy * speed)
  end

  table.insert(weapons, weapon)
end

function weapons:update(dt)

  -- Iterate through all weapons
  for i, w in ipairs(weapons) do

    if w.physics:enter('Wall') then
      w.physics:destroy()
      w.dead = true
    end

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