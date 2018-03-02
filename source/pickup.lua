-- Stores all pickups in the map
pickups = {}

-- Spawns a pickup, name is used to identify the type of pickup
function spawnPickup(name, x, y)

  -- If we already collected the pickup, don't spawn it
  if gameState.pickups["name"] then
      return nil
  end

  local pickup = {}
  pickup.name = name
  pickup.dead = false
  pickup.float = true

  if name == "blaster" then
    pickup.physics = world:newCircleCollider(x, y, 32)
  end

  if name == "missile" then
    pickup.physics = world:newCircleCollider(x, y, 32)
  end

  if name == "harpoon" then
    pickup.physics = world:newCircleCollider(x, y, 32)
  end

  -- Needed so we can reference the pickup table given its physics
  pickup.physics.parent = pickup

  table.insert(pickups, pickup)

end

-- Update all pickups currently in the map
function pickups:update(dt)

  for i, p in ipairs(pickups) do

    -- float functionality goes here

    -- colliding with the player
    if p.physics:enter('Player') then
      -- sets the appropriate pickup value
      gameState.pickups[p.name] = true
      p.physics:destroy()
      p.dead = true

      if p.name == "blaster" then
        player.weapon = 1
      end
    end

  end

  -- Iterate through all pickups in reverse to remove dead pickups from table
  for i=#pickups,1,-1 do
    if pickups[i].dead then
      table.remove(pickups, i)
    end
  end

end
