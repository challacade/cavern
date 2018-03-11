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

function breakables:update(dt)

  -- Iterate through all breakables in reverse to remove dead ones
  for i=#breakables,1,-1 do
    if breakables[i].dead then

      -- SPAWN PARTICLES HERE
      
      breakables[i].physics:destroy()
      table.remove(breakables, i)

    end
  end

end
