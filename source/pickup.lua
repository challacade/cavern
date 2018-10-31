-- Stores all pickups in the map
pickups = {}

-- Spawns a pickup, name is used to identify the type of pickup
function spawnPickup(name, x, y)

  -- If we already collected the pickup, don't spawn it
  if gameState.pickups[name] then
    return nil
  end

  local pickup = {}
  pickup.name = name
  pickup.dead = false
  pickup.float = true
  pickup.radius = 40
  pickup.timer = 0.1
  pickup.scale = 0.16

  -- used for floating
  pickup.state = 0
  pickup.tween = nil
  pickup.startY = y
  pickup.y = y

  pickup.physics = world:newCircleCollider(x, y, pickup.radius)

  pickup.sprite = sprites.pickups.item

  if name == "blaster" then
    pickup.sprite = sprites.pickups.blaster
  elseif name == "rocket" then
    pickup.sprite = sprites.pickups.rocketLauncher
    pickup.scale = 0.2
  elseif name == "harpoon" then
    pickup.sprite = sprites.pickups.spearGun
  elseif name == "aquaPack" then
    pickup.sprite = sprites.pickups.aquaPack
    pickup.scale = 0.21
  elseif name == "health1" or name == "health2" then
    pickup.sprite = sprites.pickups.health
  end

  -- Set the pickup's collision class
  pickup.physics:setCollisionClass('Pickup')

  -- Needed so we can reference the pickup table given its physics
  pickup.physics.parent = pickup

  table.insert(pickups, pickup)

end

-- Update all pickups currently in the map
function pickups:update(dt)

  for i, p in ipairs(pickups) do

    -- float functionality goes here
    if p.state == 0 then
      local destY = p.y + 20
      p.tween = flux.to(p, 2.5, {y = destY}):ease("quadinout")
      p.state = 1
    elseif p.state == 1 then
      if p.y == p.startY + 20 then
        local destY = p.y - 40
        p.tween = flux.to(p, 2.5, {y = destY}):ease("quadinout")
        p.state = 2
      end
    elseif p.state == 2 then
      if p.y == p.startY - 20 then
        local destY = p.y + 40
        p.tween = flux.to(p, 2.5, {y = destY}):ease("quadinout")
        p.state = 1
      end
    end

    p.physics:setY(p.y)

    -- colliding with the player
    if p.physics:enter('Player') then
      -- sets the appropriate pickup value
      gameState.pickups[p.name] = true
      p.physics:destroy()
      p.dead = true
      soundManager:play("itemGet")

      if p.name == "blaster" then
        player.weapon = 1
        textBox:start("blaster")
      elseif p.name == "rocket" then
        player.weapon = 2
        textBox:start("rocket")
      elseif p.name == "harpoon" then
        player.weapon = 3
        textBox:start("harpoon")
      elseif p.name == "aquaPack" then
        textBox:start("aquaPack")
      elseif p.name == "health1" or p.name == "health2" then
        gameState.player.maxHealth = gameState.player.maxHealth + 5
        player.health = gameState.player.maxHealth
        textBox:start("health")
      end
    end

    p.timer = updateTimer(p.timer, dt)

    --[[

    -- Spawn a sparkle
    if p.timer == 0 then

      local px, py = p.physics:getPosition()

      -- Seed the randomness with the pickup's Y position
      -- (since it is constantly moving)
      math.randomseed(py)

      local moveVector = vector(10, 0)
      moveVector:rotateInplace(math.random(0, 2 * math.pi))
      spawnParticle(px, py, "pickupSparkle", moveVector)
      p.timer = 0.2

    end

    ]]

  end

  -- Iterate through all pickups in reverse to remove dead pickups from table
  for i=#pickups,1,-1 do
    if pickups[i].dead then
      table.remove(pickups, i)
    end
  end

end

-- Draw all pickups
function pickups:draw()
  for _,p in ipairs(self) do
    local px, py = p.physics:getPosition()
    love.graphics.setColor(1, 1, 1, 1)

    -- Background sprite
    local bg = sprites.pickups.pickup_back
    love.graphics.draw(bg, px, py, nil, 1, 1, bg:getWidth()/2, bg:getHeight()/2)

    -- Actual pickup sprite
    love.graphics.draw(p.sprite, px, py, nil, p.scale, nil, p.sprite:getWidth()/2, p.sprite:getHeight()/2)
  end
end
