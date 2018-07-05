-- Blocks that can be blown up by the rocket luancher
breakables = {}

function spawnBreakable(x, y)

  local newBreak = {}
  newBreak.breakable = true
  newBreak.dead = false

  newBreak.x = x
  newBreak.y = y
  newBreak.width = 256
  newBreak.height = 256

  newBreak.physics = world:newRectangleCollider(x, y, newBreak.width, newBreak.height)
  newBreak.physics.parent = newBreak
  newBreak.physics:setCollisionClass('Wall')
  newBreak.physics:setType('static')

  -- These variables are needed for drawing the rocky surface
  newBreak.up = true
  newBreak.down = true
  newBreak.left = true
  newBreak.right = true

  math.randomseed(table.getn(breakables))
  newBreak.crackRot = math.random() * 3.14

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
