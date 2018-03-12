-- Collision Classes used with windfield (see the libraries)
function getCollisionClasses()
  world:addCollisionClass('Ignore', {ignores = {'Ignore'}})
  world:addCollisionClass('Pickup', {ignores = {'Ignore'}})
  world:addCollisionClass('Player', {ignores = {'Ignore'}})
  world:addCollisionClass('Enemy', {ignores = {'Ignore', 'Pickup'}})
  world:addCollisionClass('P_Weapon', {ignores = {'Ignore', 'Player', 'Pickup'}})
  world:addCollisionClass('Wall', {ignores = {'Ignore'}})
  world:addCollisionClass('Breakable', {ignores = {'Ignore'}})
  world:addCollisionClass('Transition', {ignores = {'Ignore'}})

  gravWorld:addCollisionClass('Particle', {ignores = {'Particle'}})
end
