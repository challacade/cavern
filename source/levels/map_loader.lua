-- Stores info about the current map
mapdata = {}
mapdata.walls = {}
mapdata.water = {}
mapdata.transitions = {}
mapdata.room = nil

function loadMaps()
  -- All maps in the game
  maps = {}
  maps.blank = sti("maps/blank.lua")
  maps.blank2 = sti("maps/blank2.lua")
  maps.rm1 = sti("maps/rm1.lua")
  maps.rm2 = sti("maps/rm2.lua")
  maps.rm3 = sti("maps/rm3.lua")
  maps.rm4 = sti("maps/rm4.lua")
  maps.rm5 = sti("maps/rm5.lua")
  maps.rm6 = sti("maps/rm6.lua")
  maps.rm7 = sti("maps/rm7.lua")
  maps.rm8 = sti("maps/rm8.lua")
  maps.rm9 = sti("maps/rm9.lua")
  maps.rm10 = sti("maps/rm10.lua")
  maps.rm11 = sti("maps/rm11.lua")
  maps.rm12 = sti("maps/rm12.lua")
  maps.rm13 = sti("maps/rm13.lua")
  maps.rm14 = sti("maps/rm14.lua")
  maps.rm15 = sti("maps/rm15.lua")
  maps.rm16 = sti("maps/rm16.lua")
  maps.rm17 = sti("maps/rm17.lua")
  maps.rm18 = sti("maps/rm18.lua")
  maps.rm19 = sti("maps/rm19.lua")
  maps.rm20 = sti("maps/rm20.lua")
  maps.rm21 = sti("maps/rm21.lua")
  maps.rm22 = sti("maps/rm22.lua")
  maps.rm23 = sti("maps/rm23.lua")
  maps.rm24 = sti("maps/rm24.lua")
  maps.rm25 = sti("maps/rm25.lua")
  maps.rm26 = sti("maps/rm26.lua")
  maps.rm27 = sti("maps/rm27.lua")
  maps.rm28 = sti("maps/rm28.lua")
  maps.rmBoss = sti("maps/rmBoss.lua")
  maps.rmBossAfter = sti("maps/rmBossAfter.lua")
  maps.rmCredits = sti("maps/rmCredits.lua")
  maps.rmIntro = sti("maps/rmIntro.lua")
  maps.rmMainMenu = sti("maps/rmMainMenu.lua")

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
      if transition.spawnX > 0 then
        player.physics:setX(transition.spawnX)
      else
        -- negative value spawns from right side of the map
        local w = mapdata.map.width * mapdata.map.tilewidth
        player.physics:setX(transition.spawnX + w)
      end
    end
    if transition.spawnY ~= 0 then
      if transition.spawnY > 0 then
        player.physics:setY(transition.spawnY)
      else
        -- negative value spawns from bottom of the map
        local h = mapdata.map.height * mapdata.map.tileheight
        player.physics:setY(transition.spawnY + h)
      end
    end

    -- Moves the player's position in the X or Y position by a certain amount
    -- in order to match the new map
    local curX, curY = player.physics:getPosition()
    local newX = curX + transition.relativeX
    local newY = curY + transition.relativeY
    player.physics:setPosition(newX, newY)
  end

  -- Destroys all objects from the previous room
  local destroyAll = require("source/levels/destroyAll")
  destroyAll()

  -- Adds wall colliders into the game world
  for i, w in ipairs(mapdata.map.layers["Walls"].objects) do
    local newWall = world:newRectangleCollider(w.x, w.y, w.width, w.height)
    newWall.x = w.x
    newWall.y = w.y
    newWall.width = w.width
    newWall.height = w.height
    newWall:setCollisionClass('Wall')
    newWall:setType('static')

    -- These values determine which sides of the wall to draw the rocky surface
    newWall.left = false
    newWall.right = false
    newWall.up = false
    newWall.down = false
    newWall.dontDraw = false
    if w.properties["left"] then
      newWall.left = true
    end
    if w.properties["right"] then
      newWall.right = true
    end
    if w.properties["up"] then
      newWall.up = true
    end
    if w.properties["down"] then
      newWall.down = true
    end
    if w.properties["dontDraw"] then
      newWall.dontDraw = true
    end

    table.insert(mapdata.walls, newWall)
  end

  -- Spawns water and ripple animations
  if mapdata.map.layers["Water"] then
    for i, w in ipairs(mapdata.map.layers["Water"].objects) do

      local offset = 0
      if w.type == "top" then
        offset = 64
      end

      local newWater = world:newRectangleCollider(w.x, w.y + offset,
        w.width, w.height - offset)

      if w.type == "top" then
        -- Collider for the top of the body of water
        newWater.ripplePhysics = world:newRectangleCollider(w.x, w.y + 8,
          w.width, 56)
        newWater.ripplePhysics:setCollisionClass('Ripple')
        newWater.ripplePhysics:setType('static')

        -- Spawn ripple animations (one at every 64px interval on the water)
        for itr=0, (w.width/64)-1 do
          spawnRipple(w.x + (itr * 64), w.y)
        end
      end

      newWater.x = w.x
      newWater.y = w.y + offset
      newWater.width = w.width
      newWater.height = w.height - offset
      newWater:setCollisionClass('Water')
      newWater:setType('static')
      table.insert(mapdata.water, newWater)

    end
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
  if mapdata.map.layers["Pickups"] then
    for i, p in ipairs(mapdata.map.layers["Pickups"].objects) do
      spawnPickup(p.name, p.x, p.y)
    end
  end

  -- Spawns all enemies in the current map
  if mapdata.map.layers["Enemies"] then
    for i, e in ipairs(mapdata.map.layers["Enemies"].objects) do
      spawnEnemy(e.x, e.y, e.type, e.properties["arg"])
    end
  end

  -- Spawns all breakable walls in the current map
  if mapdata.map.layers["Breakables"] then
    for i, b in ipairs(mapdata.map.layers["Breakables"].objects) do
      spawnBreakable(b.x, b.y)
    end
  end

  -- Spawns vines in the current map
  if mapdata.map.layers["Vines"] then
    for i, v in ipairs(mapdata.map.layers["Vines"].objects) do
      spawnVine(v.x, v.y)
    end
  end

  -- Spawns the save block in the current map
  if mapdata.map.layers["Saves"] then
    for i, s in ipairs(mapdata.map.layers["Saves"].objects) do
      saveUtil:spawnSave(s.x, s.properties["num"])
    end
  end

  -- Used by the camera
  mapdata.room = mapdata.map.layers["Room"].objects[1]

  -- Update the gameState with this room name
  gameState.room = newMap

  -- Update Background Color
  love.graphics.setBackgroundColor( 0.055, 0.039, 0.027 )

  if gameState.room == "rmIntro" then
    love.graphics.setBackgroundColor(0, 0, 0, 1)
  end

  -- put the camera at the correct position in this new map
  -- (dt isn't needed for the function, so passing 0 here is fine)
  cam:update(0)

  -- Reset the background parallax
  background:reset()

end
