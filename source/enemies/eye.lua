eyes = {}

function spawnEye(x, y, rot, spr, id)

  local eye = {}
  eye.x = x
  eye.y = y
  eye.rot = rot
  eye.spr = spr
  eye.id = id

  eye.dead = false

  function eye:update(dt, x, y, rot)

    eye.x = x
    eye.y = y
    eye.rot = rot

  end

  table.insert(eyes, eye)

end

-- Update an eye given the ID
function eyes:updateByID(dt, id, x, y, rot)

  for _,e in ipairs(eyes) do

    if e.id == id then
      e:update(dt, x, y, rot)
    end

    return -- no need to continue the loop

  end

end

function eyes:update(dt)

  -- Iterate through all eyes in reverse to remove dead ones
  for i=#eyes,1,-1 do
    if eyes[i].dead then
      table.remove(eyes, i)
    end
  end

end
