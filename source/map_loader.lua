-- Stores info about the current map
mapdata = {}
mapdata.walls = {}
mapdata.room = nil

function loadMaps()
  -- All maps in the game
  maps = {}
  maps.blank = sti("maps/blank.lua")
end

function changeToMap(newMap)
  mapdata.map = newMap

  -- Destroy all walls that were spawned for the previous level
  for i, w in ipairs(mapdata.walls) do
    w:destroy()
  end

  -- Adds wall colliders into the game world
  for i, w in ipairs(mapdata.map.layers["Walls"].objects) do
    local newWall = world:newRectangleCollider(w.x, w.y, w.width, w.height)
    newWall:setCollisionClass('Wall')
    newWall:setType('static')
    table.insert(mapdata.walls, enemy)
  end

  -- Used by the camera
  mapdata.room = mapdata.map.layers["Room"].objects[1]
end
