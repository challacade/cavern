local function updateGameplay(dt)

  -- Update the main physics world
  world:update(dt)

  -- Update the gravity physics world
  gravWorld:update(dt)

  -- Update trail table (must be done before weapons are updated)
  trails:update(dt)

  -- Update the player
  player:update(dt)

  -- Update all weapons
  weapons:update(dt)

  -- Update all enemies
  enemies:update(dt)

  -- Update all pickup objects in the current map
  pickups:update(dt)

  -- Update the saveUtil (for the saveMessage)
  saveUtil:update(dt)

  -- Update camera
  cam:update(dt)

  -- Update background (for parallax)
  background:update(dt)

  -- Update the screen-shake (called right after cam:update)
  shake:update(dt)

  -- Update damage text
  damages:update(dt)

  -- Update all particles
  particles:update(dt)

  -- Update all blasts
  blasts:update(dt)

  -- Update water ripple animations
  ripples:update(dt)

  -- Update projectiles shot by spike enemies
  spikes:update(dt)

  -- Update enemy projectiles
  enemyProjectiles:update(dt)

  -- Update eggs from the final boss
  eggs:update(dt)

  -- Update the vines that come up from the ground
  vines:update(dt)

  -- Update fire particles
  fires:update(dt)

  -- Update tweens
  flux.update(dt)

  -- Update to remove dead breakable walls
  breakables:update(dt)

  -- Update the blackScreen
  blackScreen:update(dt)

  -- Update the Sound Manager
  soundManager:update(dt)

  -- Update the flash
  flash:update(dt)

  -- Handle trail fade-away (when its weapon is destroyed)
  trails:fadeOut(dt)

  -- Update the tutorial
  tutorial:update(dt)

  -- Update the intro sequence (if necessary)
  intro:update(dt)

end

return updateGameplay
