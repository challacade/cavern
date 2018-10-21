-- Distance formula
function distance(x1, y1, x2, y2)
  return math.sqrt((y2 - y1)^2 + (x2 - x1)^2)
end

-- Speed given X and Y velocity values
function speedFromVelocity(vx, vy)
  return math.sqrt(vx * vx + vy * vy)
end

-- Returns a normalized HUMP vector towards the player from (mx, my)
-- If no parameters are given, it's assumed to be the mouse's position
function toPlayerVector(mx, my)
  local px, py = player.physics:getPosition()
  local reverse = true
  if mx == nil and my == nil then
    mx, my = cam:mousePosition()
    mx = mx
    my = my
    reverse = false
  end

  if reverse then
    return vector.new(px-mx, py-my):normalized()
  else
    return vector.new(mx-px, my-py):normalized()
  end
end

function toMouseVector(px, py)
  local mx, my = cam:mousePosition()
  return vector.new(mx-px, my-py):normalized()
end

-- Gets radians needed to rotate towards the player
function toPlayerRotate(mx, my)
  local dir = toPlayerVector(mx, my)
  local vx, vy = dir:normalized():unpack()
  return math.atan2(vy, vx)
end

-- Update timer variables
function updateTimer(v, dt)
  if v > 0 then
    v = v - dt
  elseif v < 0 then
    v = 0
  end

  return v
end

-- Distance between object and player
function distToPlayer(mx, my)
  local px, py = player.physics:getPosition()
  return distance(px, py, mx, my)
end
