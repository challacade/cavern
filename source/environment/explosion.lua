function explode(x, y)

  local radius = 350

  -- finds all enemies in the blast radius
  local ens = world:queryCircleArea(x, y, radius, {'Enemy'})
  for i,e in ipairs(ens) do
    e.parent:damage(100)
  end

  shake:start(0.01, 12, 0.005, 0.25)

  expX = x
  expY = y

end
