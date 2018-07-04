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
  end

  enemy = init(enemy, x, y, arg)

  enemy.maxHealth = enemy.health

  -- This update function is the same for all enemies, regardless of type
  function enemy:genericUpdate(dt)

    -- Destroy if no health left
    if self.health <= 0 then
      self.physics:destroy()
      self.dead = true

      -- Destroy loaded spike projectiles that haven't launched yet
      if self.type == "spike" then
        for _,s in ipairs(spikes) do
          if s.id == self.id then
            s.dead = true
          end
        end
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
      love.graphics.setColor(255, 0, 0, 255)
      love.graphics.rectangle("fill", ex-self.barWidth/2, ey-self.barY,
        self.barWidth, self.barHeight)

      -- front part, that shows the amount of health left
      love.graphics.setColor(0, 255, 0, 255)
      love.graphics.rectangle("fill", ex-self.barWidth/2, ey-self.barY,
        self.barWidth * (self.health / self.maxHealth), self.barHeight)

    end
  end

  function enemy:damage(d)
    self.health = self.health - d
    local ex, ey = self.physics:getPosition()
    damages:spawnDamage(ex, ey, d)
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
    if enemies[i].dead then
      table.remove(enemies, i)
    end
  end

end

-- Draw enemies
function enemies:draw()
  for i,e in ipairs(self) do
    e:draw()
    e:drawHealthBar()
  end
end
