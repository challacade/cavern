-- This function is called when a new map is loaded.
-- Before the objects in the new map are created, the objects from the old map
-- need to be deleted.

local function destroyAll()

  -- Destroy all walls that were spawned for the previous map
  for i, w in ipairs(mapdata.walls) do
    w:destroy()
    mapdata.walls[i] = nil
  end

  -- Destroy all vines that were spawned for the previous map
  for i, v in ipairs(vines) do
    v:destroy()
    vines[i] = nil
  end

  -- Destroy all spikes that were spawned for the previous map
  for i, s in ipairs(spikes) do
    s.dead = true
  end

  -- Destroy all walls that were spawned for the previous map
  for i, w in ipairs(mapdata.water) do
    if w.ripplePhysics ~= nil then
      w.ripplePhysics:destroy()
    end
    w:destroy()
    mapdata.water[i] = nil
  end

  -- Destroys all water ripples
  ripples:destroy()

  -- Destroy all transition objects from the previous map
  for i, t in ipairs(mapdata.transitions) do
    t:destroy()
    mapdata.transitions[i] = nil
  end

  -- Destroy all breakable objects from the previous map
  for i, b in ipairs(breakables) do
    b.physics:destroy()
    breakables[i] = nil
  end

  -- Destroy all pickup objects from the previous map
  for i, p in ipairs(pickups) do
    p.physics:destroy()
    pickups[i] = nil
  end

  -- Destroy all enemies from the previous map
  for i, e in ipairs(enemies) do
    e.physics:destroy()
    enemies[i] = nil
  end

  -- Iterate through all weapons in reverse to remove dead weapons from table
  for i=#weapons,1,-1 do
    weapons[i].physics:destroy()
    table.remove(weapons, i)
  end

  for i=#fires,1,-1 do
    table.remove(fires, i)
  end

  -- Move the saveBlock offscreen so the player can't hit
  saveUtil.saveBlock.x = -1000

end

return destroyAll
