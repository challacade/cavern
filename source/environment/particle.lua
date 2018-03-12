-- Used for particle effects, like explosions, fire, breaking walls, etc.
particles = {}

-- Particles use gravWorld, since they are affected by gravity

function spawnParticle(x, y, type, dir)

  local particle = {}

  particle.x = x
  particle.y = y
  particle.width = 50
  particle.height = 50
  particle.corner = 10

  -- dir is a vector value used for applying an impulse upon creation
  particle.dir = dir

  -- When timer reaches zero, particle is destroyed
  particle.timer = 1

  if type == "break" then
    particle.width = 64
    particle.height = 64
    particle.corner = 2
    particle.timer = 1.5
  end

  particle.physics = gravWorld:newBSGRectangleCollider(x, y, particle.width,
    particle.height, particle.corner)
  particle.physics:setFixedRotation(true)
  particle.physics:setCollisionClass('Particle')

  if particle.dir ~= nil then
    particle.physics:applyLinearImpulse(particle.dir:unpack())
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
      table.remove(particles, i)
    end
  end

end
