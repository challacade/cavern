function distance(x1, y1, x2, y2)
  return math.sqrt((y2 - y1)^2 + (x2 - x1)^2)
end

function speedFromVelocity(vx, vy)
  return math.sqrt(vx * vx + vy * vy)
end

function playerVector(mx, my)
  local px, py = player.physics:getPosition()
  local reverse = true
  if mx == nil and my == nil then
    mx, my = cam:mousePosition()
    mx = mx
    my = my
    reverse = false
  end
  local dist = distance(px, py, mx, my)

  local vx = (mx - px) / dist
  local vy = (my - py) / dist

  if reverse then
    vx = vx * -1
    vy = vy * -1
  end

  return vx, vy
end

function updateTimer(v, dt)
  if v > 0 then
    v = v - dt
  elseif v < 0 then
    v = 0
  end
  
  return v
end
