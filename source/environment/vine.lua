-- These are vines that the player shoots, and they sink into the ground
vines = {}

function spawnVine(x, y)

  local vine = world:newRectangleCollider(x, y, 128, 640)
  vine:setCollisionClass('Wall')
  vine:setType('static')

  vine.sinkTimer = 0
  vine.speed = 320

  function vine:update(dt)

    self.sinkTimer = updateTimer(self.sinkTimer, dt)
    if self.sinkTimer > 0 then
      self:setY(self:getY() + self.speed * dt)
    end

    if self:enter('P_Weapon') then
      local wep = self:getEnterCollisionData('P_Weapon')
      if wep.collider.parent.type == 1 then
        self.sinkTimer = 0.35
        self.speed = 320
      else
        self.sinkTimer = 0.9
        self.speed = 640
      end
    end

  end

  table.insert(vines, vine)

end

function vines:update(dt)

  for i,v in ipairs(self) do
    v:update(dt)
  end

end
