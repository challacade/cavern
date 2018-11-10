function explode(x, y)

  soundManager:play("explosion")

  local radius = 315

  -- Spawn the particles for the explosion
  local scl = 12
  local spd = 240
  local life = 0.8
  for inc=1, 7 do
    spd = spd * 0.8
    life = life * 1.1
    if inc == 7 then
      spd = 32 -- This is so the middle particles stay more centralized
    end
    fires:spawnFire(x, y, life, vector(1, 1), scl, nil, spd)
    fires:spawnFire(x, y, life, vector(1, 0), scl, nil, spd)
    fires:spawnFire(x, y, life, vector(1, -1), scl, nil, spd)
    fires:spawnFire(x, y, life, vector(0, 1), scl, nil, spd)
    fires:spawnFire(x, y, life, vector(-1, -1), scl, nil, spd)
    fires:spawnFire(x, y, life, vector(-1, 0), scl, nil, spd)
    fires:spawnFire(x, y, life, vector(-1, 1), scl, nil, spd)
    fires:spawnFire(x, y, life, vector(0, -1), scl, nil, spd)
	end

  -- finds all enemies in the blast radius
  local ens = world:queryCircleArea(x, y, radius, {'Enemy'})
  for i,e in ipairs(ens) do
    if e.parent.type ~= "fish" then
      e.parent:damage(25)
    end
  end

  -- finds all breakable walls in the blast radius
  local br = world:queryCircleArea(x, y, radius, {'Wall'})
  for i,b in ipairs(br) do
    if b.parent ~= nil and b.parent.breakable then
      b.parent.dead = true
    end
  end

  shake:start(0.01, 12, 0.005, 0.25)

  expX = x
  expY = y

end
