local function updateGameplay(dt)

  -- Update the physics world
  world:update(dt)

  -- Update the player
  player:update(dt)

  -- Update all weapons
  weapons:update(dt)

  -- Update all enemies
  enemies:update(dt)

  -- Update all pickup objects in the current map
  pickups:update(dt)

  -- Update camera
  cam:update(dt)

  -- Update damage text
  damages:update(dt)

  -- Update tweens
  flux.update(dt)

end

return updateGameplay
