-- Used for particle effects, like explosions, fire, breaking walls, etc.
particles = {}

-- Particles use gravWorld, since they are affected by gravity

function spawnParticle(x, y, type, dir, time)

  local particle = {}

  particle.x = x
  particle.y = y
  particle.width = 50
  particle.height = 50
  particle.corner = 10
  particle.sprite = nil
  particle.type = type
  particle.fade = true
  particle.fadeIn = false
  particle.gravity = true

  -- dir is a vector value used for applying an impulse upon creation
  particle.dir = dir

  -- When timer reaches zero, particle is destroyed
  particle.timer = 1

  math.randomseed(table.getn(particles))

  if type == "break" then
    particle.width = 71
    particle.height = 71
    particle.corner = 2
    particle.timer = 1.5
    particle.scale = math.random() * 0.5 + 0.5
    particle.rotate = math.random() * 3.14
    particle.alpha = 1
  end

  if type == "laserDebris" then
    particle.width = 8
    particle.height = 8
    particle.corner = 1
    particle.timer = 0.5
    particle.alpha = 0.314
  end

  if type == "pickupSparkle" then
    particle.width = 4
    particle.height = 4
    particle.corner = 1
    particle.timer = 0.5
    particle.alpha = 0.314
    particle.gravity = false
  end

  if type == "splash" then
    particle.width = 12
    particle.height = 12
    particle.radius = 7
    particle.corner = 3
    particle.timer = math.abs(player.velY) / 450
    particle.alpha = 0.5
    particle.gravity = true
  end

  if type == "droplet" then
    particle.width = 6
    particle.height = 6
    particle.radius = 3
    particle.corner = 1
    particle.timer = 0.5
    particle.alpha = 0.15
    particle.gravity = true
    particle.fadeIn = true
  end

  particle.timer = time or particle.timer

  local particleWorld = gravWorld

  if particle.gravity == false then
    particleWorld = world
  end

  particle.physics = particleWorld:newBSGRectangleCollider(x, y, particle.width,
    particle.height, particle.corner)
  particle.physics:setFixedRotation(true)

  if particle.gravity then
    particle.physics:setCollisionClass('Particle')
  else
    particle.physics:setCollisionClass('Ignore')
  end

  if particle.dir ~= nil then
    particle.physics:applyLinearImpulse(particle.dir:unpack())
  end

  if particle.fade then
    if particle.fadeIn then
      particle.fadeTween = flux.to(particle, particle.timer, {alpha = 0}):ease("backin")
    else
      particle.fadeTween = flux.to(particle, particle.timer, {alpha = 0}):ease("cubicin")
    end
  end

  function particle:update(dt)

    self.timer = updateTimer(self.timer, dt)

    if self.timer <= 0 then
      self.dead = true
    end

  end

  table.insert(particles, particle)

end

-- call update on all particles, destroy the dead ones
function particles:update(dt)

  for i,p in ipairs(self) do
    p:update(dt)
  end

  for i=#particles,1,-1 do
    if particles[i].dead then
      particles[i].physics:destroy()
      particles[i].fadeTween = nil
      table.remove(particles, i)
    end
  end

end

function particles:draw()

  for i,p in ipairs(self) do

    local px, py = p.physics:getPosition()

    if p.type == "break" then
      love.graphics.setColor(0.247, 0.176, 0.114, p.alpha)
      love.graphics.draw(sprites.environment.breakParticle, px, py, nil, 0.5, 0.5, 35, 35)
    end

    if p.type == "laserDebris" then
      love.graphics.setColor(1, 0, 0, p.alpha)
      love.graphics.rectangle("fill", px-4, py-4, 8, 8)
    end

    if p.type == "pickupSparkle" then
      love.graphics.setColor(1, 1, 1, p.alpha)
      love.graphics.circle("fill", px, py, 4)
    end

    if p.type == "splash" or p.type == "droplet" then
      local add = 1 - p.alpha
      if add < 0 then
        add = 0
      end
      love.graphics.setColor(0.388 + add, 0.502 + add, 0.541 + add, p.alpha)
      love.graphics.circle("fill", px, py, p.radius)
    end

  end

end

function particles:splash(x, y)
  local mag = math.abs(player.velY) * -0.35

  if player.velY > 0 then
    spawnParticle(x, y, "splash", vector(0, mag))

    spawnParticle(x-15, y, "splash", vector(-10, mag*0.97))
    spawnParticle(x+15, y, "splash", vector(10, mag*0.97))

    spawnParticle(x-30, y, "splash", vector(-25, mag*0.84))
    spawnParticle(x+30, y, "splash", vector(25, mag*0.84))

  --[[
    spawnParticle(x-15, y, "splash", vector(-10, mag*0.8))
    spawnParticle(x+15, y, "splash", vector(10, mag*0.8))

    spawnParticle(x, y, "splash", vector(0, mag * 0.86))
    ]]
  else
    spawnParticle(x-15, y, "splash", vector(-35, mag*0.97))
    spawnParticle(x+15, y, "splash", vector(35, mag*0.97))

    spawnParticle(x-30, y, "splash", vector(-50, mag*0.84))
    spawnParticle(x+30, y, "splash", vector(50, mag*0.84))
  end
end
