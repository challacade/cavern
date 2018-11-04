-- These are vines that the player shoots, and they sink into the ground
vines = {}

function spawnVine(x, y)

  local vine = world:newRectangleCollider(x + 32, y + 16, 64, 640)
  vine:setCollisionClass('Wall')
  vine:setType('static')

  vine.trueX = vine:getX()
  vine.trueY = vine:getY()

  vine.sinkTimer = 0
  vine.speed = 320
  vine.offset = 0
  vine.offsetTween = nil

  function vine:update(dt)

    self.sinkTimer = updateTimer(self.sinkTimer, dt)
    if self.sinkTimer > 0 then
      self.trueY = self.trueY + self.speed * dt
    end

    if self:enter('P_Weapon') then
      local wep = self:getEnterCollisionData('P_Weapon')
      if wep.collider.parent.type == 1 then
        self.sinkTimer = 0.35
        self.speed = 320
      else
        self.sinkTimer = 0.8
        self.speed = 640
      end
    end

    if self.offset == 0 then
      self.offset = 1
      self.offsetTween = flux.to(self, 4, {offset = 32}):ease("quadinout")
    elseif self.offset == 32 then
      self.offsetTween = flux.to(self, 4, {offset = 0}):ease("quadinout")
    end

    self:setPosition(self.trueX, self.trueY + self.offset)

  end

  table.insert(vines, vine)

end

function vines:update(dt)

  for i,v in ipairs(self) do
    v:update(dt)
  end

end

function vines:draw()

  for i,v in ipairs(self) do
    love.graphics.setColor(1, 1, 1, 1)
    local vx, vy = v:getPosition()
    love.graphics.draw(sprites.environment.vine, vx-32, vy-320)
  end

end
