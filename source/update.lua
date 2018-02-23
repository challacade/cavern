local function updateGameplay(dt)

  -- Update the physics world
  world:update(dt)

  -- Update the player
  player:update(dt)

  -- Update all weapons
  weapons:update(dt)

  -- Update all enemies
  enemies:update(dt)

  -- Update camera
  cam:update(dt)

end

return updateGameplay
