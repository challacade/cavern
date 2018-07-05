-- spikes launched by "spike" enemies
spikes = {}

function spawnSpike(x, y, num, id, groundDir)

  local spike = {}
  spike.dir = vector.new(-1, 0)
  spike.dead = false
  spike.power = 6
  spike.id = id
  spike.sprite = sprites.enemies.spikeProj

  -- Originally planned to have spikes pause before launching
  -- Since this is no longer needed, just keep this timer at -1
  -- so they immediately launch
  spike.launchTimer = -1

  -- Assign dir (vector)
  if num == 1 then -- left
    spike.dir = vector.new(-1, 0)
  elseif num == 2 then -- up-left
    spike.dir = vector.new(-1, -1)
  elseif num == 3 then -- up
    spike.dir = vector.new(0, -1)
  elseif num == 4 then -- up-right
    spike.dir = vector.new(1, -1)
  elseif num == 5 then -- right
    spike.dir = vector.new(1, 0)
  end

  -- Rotate dir based on host's groundDir value
  if groundDir == "left" then
    spike.dir:rotateInplace(math.pi / 2) -- rotate by 90 degrees
  elseif groundDir == "up" then
    spike.dir:rotateInplace(math.pi) -- rotate by 180 degrees
  elseif groundDir == "right" then
    spike.dir:rotateInplace(math.pi / -2) -- rotate by -90 degrees
  end

  spike.dir:normalizeInplace()
  spike.dir = spike.dir * 64 -- radius of spike enemies

  local tempX, tempY = spike.dir:unpack()
  x = x + tempX
  y = y + tempY

  spike.physics = world:newCircleCollider(x, y, 16)
  spike.physics:setCollisionClass('E_Weapon')
  spike.dir = spike.dir:normalized()

  function spike:update(dt)

    --self.launchTimer = updateTimer(self.launchTimer, dt)
    if self.launchTimer < 0 then
      self.physics:applyLinearImpulse((self.dir * 1500):unpack())
      self.launchTimer = 0

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

function spikes:draw()

  love.graphics.setColor(1, 1, 1, 1)

  for i,s in ipairs(self) do
    local sprX, sprY = s.physics:getPosition()
    local sprW = s.sprite:getWidth()
    local sprH = s.sprite:getHeight()

    local vx, vy = s.dir:unpack()
    local rotate = math.atan2(vy, vx)

    love.graphics.draw(s.sprite, sprX, sprY, rotate, 1, 1, sprW/2, sprH/2)
  end

end
