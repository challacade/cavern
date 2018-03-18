local function updateGameplay(dt)

  -- Update the main physics world
  world:update(dt)

  -- Update the gravity physics world
  gravWorld:update(dt)

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

  -- Update the screen-shake (called right after cam:update)
  shake:update(dt)

  -- Update damage text
  damages:update(dt)

  -- Update all particles
  particles:update(dt)

  -- Update water ripple animations
  ripples:update(dt)

  -- Update projectiles shot by spike enemies
  spikes:update(dt)

  -- Update tweens
  flux.update(dt)

  -- Update to remove dead breakable walls
  breakables:update(dt)

end

return updateGameplay
