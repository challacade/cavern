sprites = {}

-- Images for drawing the player
sprites.player = {}
sprites.player.helmet = love.graphics.newImage('sprites/player/helmet.png')
sprites.player.body = love.graphics.newImage('sprites/player/body.png')
sprites.player.armEmpty = love.graphics.newImage('sprites/player/arm_empty.png')
sprites.player.armBlaster = love.graphics.newImage('sprites/player/arm_blaster.png')

-- Images for everything relating to the environment and levels
sprites.environment = {}
sprites.environment.waterSheet = love.graphics.newImage('sprites/environment/waterSheet.png')

-- Individual blob shapes for drawing fire
sprites.fire = {}
sprites.fire.f1 = love.graphics.newImage('sprites/fire/fire_1.png')
sprites.fire.f2 = love.graphics.newImage('sprites/fire/fire_2.png')
sprites.fire.f3 = love.graphics.newImage('sprites/fire/fire_3.png')
sprites.fire.f4 = love.graphics.newImage('sprites/fire/fire_4.png')
sprites.fire.f5 = love.graphics.newImage('sprites/fire/fire_5.png')
