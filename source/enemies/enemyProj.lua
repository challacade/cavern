-- projectiles launched by enemies (does not include spikes)
enemyProjectiles = {}

function spawnEnemyProj(x, y, dir, type)

  local enProj = {}
  enProj.dir = dir
  enProj.dead = false
  enProj.power = 6
  enProj.id = math.random()
  enProj.rad = 10
  enProj.sprite = nil
  enProj.impulse = 2000

  if type == "fish" then
    enProj.rad = 19
    enProj.power = 6
    enProj.sprite = sprites.enemies.evilBubble
    enProj.impulse = 2500
    soundManager:play("starfish")
  end

  if type == "bossLaser" then
    enProj.rad = 10
    enProj.power = 7
    enProj.sprite = nil
    enProj.impulse = 3000
    -- This projectile has a trail, which is spawned here
    spawnTrail(enProj.id, 12, 16, {1, 0, 0, 0.706})

    soundManager:play("bossLaser")

    -- Offset the starting location of the laser
    -- so it appears in the eye's pupil
    local offsetVec = enProj.dir * 100
    local wx, wy = offsetVec:unpack()
    x = x + wx
    y = y + wy
  end

  enProj.physics = world:newCircleCollider(x, y, enProj.rad)
  enProj.physics:setCollisionClass('E_Weapon')
  enProj.dir = enProj.dir:normalized()

  enProj.physics:applyLinearImpulse((enProj.dir * enProj.impulse):unpack())

  function enProj:update(dt)

    -- Hurt player on contact
    if self.physics:enter('Player') then
      player:hurt(self.power)
      self.dead = true
    end

    if self.physics:enter('Wall') or self.physics:enter('Breakable')
      or self.physics:enter('Transition') then
        self.dead = true
    end

  end

  table.insert(enemyProjectiles, enProj)

end

function enemyProjectiles:update(dt)

  for i,s in ipairs(self) do
    s:update(dt)
  end

  -- Iterate through all enemyProjectiles in reverse to remove dead ones
  -- Update trails before removal
  for i=#enemyProjectiles,1,-1 do

    local proj = enemyProjectiles[i]

    -- Updates the projectile's trail (if it has one)
    if proj.dead ~= true then
      for _,t in ipairs(trails) do
        if t.id == proj.id then
          t:update(dt, proj)
        end
      end
    end

    if proj.dead then
      proj.physics:destroy()
      table.remove(enemyProjectiles, i)
    end

  end

end

function enemyProjectiles:draw()

  love.graphics.setColor(1, 1, 1, 1)

  for i,p in ipairs(self) do

    if p.sprite ~= nil then
      local sprX, sprY = p.physics:getPosition()
      local sprW = p.sprite:getWidth()
      local sprH = p.sprite:getHeight()
      love.graphics.draw(p.sprite, sprX, sprY, nil, 1, 1, sprW/2, sprH/2)
    end

  end

end
