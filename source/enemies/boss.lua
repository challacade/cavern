local function bossInit(enemy, x, y, arg)

  -- Initialize physics
  enemy.physics = world:newBSGRectangleCollider(x, y, 256, 256, 82)
  enemy.physics:setCollisionClass('Enemy')
  enemy.physics:setType('static')
  enemy.physics:setFixedRotation(true)
  -- We need this to access the table itself given the physics
  enemy.physics.parent = enemy

  -- Properties
  enemy.health = 300
  enemy.hitPower = 12
  enemy.moveForce = 11000
  enemy.maxSpeed = 400
  enemy.barY = 1000 -- Putting the health bar above the screen

  -- Sprite info
  enemy.sprite = sprites.enemies.bossBody

  --enemy.eye = spawnEye(x, y, 0, 1, sprites.enemies.flyerEye)

  function enemy:update(dt)

  end

  function enemy:draw()
    local sprX, sprY = self.physics.body:getPosition()

    -- Draw the body of the boss
    sprW = self.sprite:getWidth()
    sprH = self.sprite:getHeight()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(self.sprite, sprX, sprY, nil, 1, 1, sprW/2, sprH/1.5)
  end

  return enemy

end

return bossInit
