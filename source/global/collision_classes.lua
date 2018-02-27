function getCollisionClasses()
  world:addCollisionClass('Ignore', {ignores = {'Ignore'}})
  world:addCollisionClass('Player', {ignores = {'Ignore'}})
  world:addCollisionClass('Enemy', {ignores = {'Ignore'}})
  world:addCollisionClass('P_Weapon', {ignores = {'Ignore', 'Player'}})
  world:addCollisionClass('Wall', {ignores = {'Ignore'}})
end
