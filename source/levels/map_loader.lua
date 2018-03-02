-- Stores info about the current map
mapdata = {}
mapdata.walls = {}
mapdata.transitions = {}
mapdata.room = nil

function loadMaps()
  -- All maps in the game
  maps = {}
  maps.blank = sti("maps/blank.lua")
  maps.blank2 = sti("maps/blank2.lua")

  -- utilize maps["blank"] syntax to read map data
end

function changeToMap(newMap, transition)
  mapdata.map = maps[newMap]
  -- Note on this syntax: in Lua, when you use table["someString"], that is
  -- accessing table.someString. Since map names are stored as strings when
  -- received from transition objects, this allows us to access the map object
  -- from the "maps" table.

  -- changeToMap may be passed "transition", which is the transition object
  -- that the player collided with to change maps. It contains data for
  -- changing the player's position for the new map
  if transition then  -- If changeToMap was passed a transition object

    -- For "Spawn" values, we only change to that position if the value is
    -- not 0. No levels spawn the player at X=0 or Y=0, so this indicates
    -- whether the Spawn value is being used for this new map.
    if transition.spawnX ~= 0 then
      player.physics:setX(transition.spawnX)
    end
    if transition.spawnY ~= 0 then
      player.physics:setY(transition.spawnY)
    end

    -- Moves the player's position in the X or Y position by a certain amount
    -- in order to match the new map
    local curX, curY = player.physics:getPosition()
    local newX = curX + transition.relativeX
    local newY = curY + transition.relativeY
    player.physics:setPosition(newX, newY)
  end

  -- Destroy all walls that were spawned for the previous map
  for i, w in ipairs(mapdata.walls) do
    w:destroy()
    mapdata.walls[i] = nil
  end

  -- Destroy all transition objects from the previous map
  for i, t in ipairs(mapdata.transitions) do
    t:destroy()
    mapdata.transitions[i] = nil
  end

  -- Destroy all pickup objects from the previous map
  for i, p in ipairs(pickups) do
    p.physics:destroy()
    pickups[i] = nil
  end

  -- Adds wall colliders into the game world
  for i, w in ipairs(mapdata.map.layers["Walls"].objects) do
    local newWall = world:newRectangleCollider(w.x, w.y, w.width, w.height)
    newWall:setCollisionClass('Wall')
    newWall:setType('static')
    table.insert(mapdata.walls, newWall)
  end

  -- Adds all transition colliders in the current map
  for i, t in ipairs(mapdata.map.layers["Transitions"].objects) do
    local newTransition = world:newRectangleCollider(t.x,t.y,t.width,t.height)
    newTransition:setCollisionClass('Transition')
    newTransition:setType('static')

    -- Used to reference full "physics" object given only the collider
    --newTransition.collider.parent = newTransition

    -- "toMap" stores the name of the map the game will change to when the
    -- player collides with the transition. This is stored in Tiled as the name
    -- of the Transition object.
    newTransition.toMap = t.name

    -- Get custom properties and add them to the new transition object
    -- These determine where the player changes his position to in the new room
    -- "Spawn" is a set X or Y position in the new map where the player will go
    -- "Relative" is the distance in the X or Y direction the player will move
    --  from his current position
    newTransition.spawnX = t.properties["spawnX"]
    newTransition.spawnY = t.properties["spawnY"]
    newTransition.relativeX = t.properties["relativeX"]
    newTransition.relativeY = t.properties["relativeY"]

    table.insert(mapdata.transitions, newTransition)
  end

  -- Spawns all pickups in the current map
  for i, p in ipairs(mapdata.map.layers["Pickups"].objects) do
    spawnPickup(p.name, p.x, p.y)
  end

  -- Used by the camera
  mapdata.room = mapdata.map.layers["Room"].objects[1]
end
