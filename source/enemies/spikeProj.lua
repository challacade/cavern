-- spikes launched by "spike" enemies
spikes = {}

function spawnSpike(x, y, num, id)

  local spike = {}
  spike.dir = vector.new(-1, 0)
  spike.launchTimer = 0.5
  spike.dead = false
  spike.power = 6
  spike.id = id

  if num == 1 then -- left
    x = x - 64
  elseif num == 2 then -- up-left
    x = x - 32
    y = y - 18
    spike.dir = vector.new(-1, -1)
  elseif num == 3 then -- up
    y = y - 32
    spike.dir = vector.new(0, -1)
  elseif num == 4 then -- up-right
    x = x + 32
    y = y - 18
    spike.dir = vector.new(1, -1)
  elseif num == 5 then -- right
    x = x + 64
    spike.dir = vector.new(1, 0)
  end

  spike.physics = world:newCircleCollider(x, y, 20)
  spike.physics:setCollisionClass('E_Weapon')
  spike.dir = spike.dir:normalized()

  function spike:update(dt)

    self.launchTimer = updateTimer(self.launchTimer, dt)
    if self.launchTimer < 0 then
      self.physics:applyLinearImpulse((self.dir * 1000):unpack())

      -- self.id is used to destroy spikes that haven't launched yet
      -- since this spike has launched, make the id invalid
      self.id = -1
    end

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

  table.insert(spikes, spike)

end

function spikes:update(dt)

  for i,s in ipairs(self) do
    s:update(dt)
  end

  -- Iterate through all spikes in reverse to remove dead ones
  for i=#spikes,1,-1 do
    if spikes[i].dead then
      spikes[i].physics:destroy()
      table.remove(spikes, i)
    end
  end

end
