-- Blocks that can be blown up by the rocket luancher
breakables = {}

function spawnBreakable(x, y)

  local newBreak = {}
  newBreak.breakable = true
  newBreak.dead = false

  newBreak.physics = world:newRectangleCollider(x, y, 256, 256)
  newBreak.physics.parent = newBreak
  newBreak.physics:setCollisionClass('Wall')
  newBreak.physics:setType('static')

  table.insert(breakables, newBreak)

end

-- spawns all particles for when a wall is blown up
function breakParticles(x, y)

  spawnParticle(x, y, "break", vector(-2500, -4500))
  spawnParticle(x, y, "break", vector(2500, -4500))
  spawnParticle(x, y, "break", vector(-4500, -2500))
  spawnParticle(x, y, "break", vector(4500, -2500))

end

function breakables:update(dt)

  -- Iterate through all breakables in reverse to remove dead ones
  for i=#breakables,1,-1 do
    if breakables[i].dead then

      local bx, by = breakables[i].physics:getPosition()
      breakParticles(bx, by)

      breakables[i].physics:destroy()
      table.remove(breakables, i)

    end
  end

end
