-- Stores all enemies currently in game
enemies = {}

-- Creates a new enemy and adds it to the enemies table
function spawnEnemy(x, y, type)
  local enemy = {}

  -- Generic properties that all enemies have
  enemy.dead = false
  enemy.hitPower = 1
  enemy.type = type

  -- Function that sets the properties of the new enemy
  local init
  if type == "bat" then
    init = require("source/enemies/bat")
  end

  enemy = init(enemy, x, y)

  -- This update function is the same for all enemies, regardless of type
  function enemy:genericUpdate(dt)

    -- Destroy if no health left
    if self.health <= 0 then
      self.physics:destroy()
      self.dead = true
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
