function explode(x, y)

  local radius = 350

  -- finds all enemies in the blast radius
  local ens = world:queryCircleArea(x, y, radius, {'Enemy'})
  for i,e in ipairs(ens) do
    e.parent:damage(100)
  end

  expX = x
  expY = y

end
