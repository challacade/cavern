-- Stores all enemies currently in game
enemies = {}

-- Creates a new enemy and adds it to the enemies table
function spawnEnemy(x, y, type, arg)
  local enemy = {}

  -- Generic properties that all enemies have
  enemy.health = 10
  enemy.dead = false
  enemy.hitPower = 1
  enemy.type = type

  -- Distance above the enemy where its healthbar is displayed
  enemy.barY = 40

  enemy.showBar = true -- set to false for the boss

  -- Width and Height of the healthbar
  enemy.barWidth = 100
  enemy.barHeight = 16

  -- Set a new seed for each enemy spawned in the room
  math.randomseed(#enemies)

  -- Function that sets the properties of the new enemy
  local init
  if type == "bat" then
    init = require("source/enemies/bat")
  elseif type == "spike" then
    init = require("source/enemies/spike")
  elseif type == "fish" then
    init = require("source/enemies/fish")
  elseif type == "boss" then
    init = require("source/enemies/boss")
  end

  enemy = init(enemy, x, y, arg)

  enemy.maxHealth = enemy.health

  -- This update function is the same for all enemies, regardless of type
  function enemy:genericUpdate(dt)

    -- Destroy if no health left
    if self.health <= 0 then
      self.dead = true
      if self.type ~= "boss" then
        local ex, ey = self.physics:getPosition()
        spawnBlast(ex, ey, 300, {0.486, 0.675, 0.561}, 0.5)
        self.physics:destroy()
      end
    end

    -- Hurt player on contact
    if self.physics:enter('Player') then
      player:hurt(self.hitPower)

      -- Certain enemies "bounce" off the player when they collide
      if self.type == "bat" then
        local mx, my = self.physics:getPosition()
        local recoilDir = toPlayerVector(mx, my) * -1500
        self.physics:applyLinearImpulse(recoilDir:unpack())
        -- give the player some recoil as well
        player.physics:applyLinearImpulse((recoilDir*-2):unpack())
      end

    end

  end

  function enemy:drawHealthBar()
    -- Only show healthbar if enemy is not at full health and not dead
    -- Also check the showBar value, it is false for some enemies
    if self.health < self.maxHealth and self.health > 0 and self.showBar then

      local ex, ey = self.physics:getPosition()

      -- back part of the bar
      love.graphics.setColor(1, 0, 0, 1)
      love.graphics.rectangle("fill", ex-self.barWidth/2, ey-self.barY,
        self.barWidth, self.barHeight)

      -- front part, that shows the amount of health left
      love.graphics.setColor(0, 1, 0, 1)
      love.graphics.rectangle("fill", ex-self.barWidth/2, ey-self.barY,
        self.barWidth * (self.health / self.maxHealth), self.barHeight)

    end
  end

  function enemy:damage(d)

    if d <= 0 then
      return nil
    end

    -- Add some randomness to the damage (if it isn't an explosion)
    if d < 20 then
      d = d + math.random(0, 1)
    end
    self.health = self.health - d
    local ex, ey = self.physics:getPosition()
    damages:spawnDamage(ex, ey, d)
    soundManager:play("enemyHurt")

  end

  -- Checks if the player can be seen by the enemy
  function enemy:inSight()

    local ex, ey = self.physics:getPosition()
    if distToPlayer(ex, ey) > 2300 then
      return false
    end

    -- This part checks to see if there are obstacles between the enemy and the
    -- player. This is accomplished by querying a rectangle that stretches
    -- between the enemy and the player, and if any walls or objects lie inside
    -- that rectangle, then it is assumed the enemy couldn't see the player.

    -- Vertices on the player's end of the rectangle
    local px, py = player.physics:getPosition()
    local pVertX1 = px-2
    local pVertY1 = py
    local pVertX2 = px+2
    local pVertY2 = py

    -- Vertices on the enemy's end
    if py == ey then
      ey = ey + 1
      -- This is just a precaution; if the rectangle ended up being completely
      -- flat (where py == ey), it may cause an error.
    end
    local eVertX1 = ex-2
    local eVertY1 = ey
    local eVertX2 = ex+2
    local eVertY2 = ey

    local queryResults = world:queryPolygonArea({pVertX1, pVertY1, pVertX2, pVertY2,
      eVertX1, eVertY1, eVertX2, eVertY2}, {'Wall', 'Breakable'})

    if table.getn(queryResults) > 0 then
      return false -- something is between the player and the enemy
    end

    return true

  end

  table.insert(enemies, enemy)
end

-- Goes through every enemy and calls its "update" function
-- Also removes enemy tables that had their physics destroyed
function enemies:update(dt)

  -- Calls update functions on all enemies
  for i,e in ipairs(self) do
    e:update(dt)
    e:genericUpdate(dt)
  end

  -- Iterate through all enemies in reverse to remove the dead ones
  for i=#enemies,1,-1 do
    if enemies[i].dead and enemies[i].type ~= "boss" then
      table.remove(enemies, i)
    end
  end

end

-- Draw all enemies
function enemies:draw(drawBoss)
  for i,e in ipairs(self) do
    if (e.type == "boss" and drawBoss) or (e.type ~= "boss" and drawBoss == false) then

      e:draw()
      e:drawHealthBar()

      if e.eye ~= nil then
        e.eye:draw()
      end

      -- only for the final boss
      if e.eyes ~= nil then
        for _,eye in ipairs(e.eyes) do
          eye:draw()
        end
      end

    end
  end
end
