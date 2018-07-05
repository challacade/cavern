-- projectiles launched by enemies (does not include spikes)
enemyProjectiles = {}

function spawnEnemyProj(x, y, dir, type)

  local enProj = {}
  enProj.dir = dir
  enProj.dead = false
  enProj.power = 6
  enProj.id = id
  enProj.rad = 10
  enProj.sprite = nil
  enProj.impulse = 2000

  if type == "fish" then
    enProj.rad = 20
    enProj.power = 8
    enProj.sprite = sprites.player.armEmpty
    enProj.impulse = 2500
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
  for i=#enemyProjectiles,1,-1 do
    if enemyProjectiles[i].dead then
      enemyProjectiles[i].physics:destroy()
      table.remove(enemyProjectiles, i)
    end
  end

end

function enemyProjectiles:draw()

  love.graphics.setColor(1, 1, 1, 1)

  for i,p in ipairs(self) do
    local sprX, sprY = p.physics:getPosition()
    local sprW = p.sprite:getWidth()
    local sprH = p.sprite:getHeight()

    love.graphics.draw(p.sprite, sprX, sprY, nil, 1, 1, sprW/2, sprH/2)
  end

end
