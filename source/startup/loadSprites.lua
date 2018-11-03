sprites = {}

-- Images for drawing the player
sprites.player = {}
sprites.player.helmet = love.graphics.newImage('sprites/newPlayer2/helmet.png')
sprites.player.body = love.graphics.newImage('sprites/newPlayer2/body.png')
sprites.player.armEmpty = love.graphics.newImage('sprites/newPlayer2/arm.png')
sprites.player.backArm = love.graphics.newImage('sprites/newPlayer2/backArm.png')
sprites.player.armBlaster = love.graphics.newImage('sprites/newPlayer2/armBlaster.png')
sprites.player.armRocket = love.graphics.newImage('sprites/newPlayer2/armRocket.png')
sprites.player.armSpear = love.graphics.newImage('sprites/newPlayer2/armSpear.png')
sprites.player.armSpearLoaded = love.graphics.newImage('sprites/newPlayer2/armSpearLoaded.png')
sprites.player.spear = love.graphics.newImage('sprites/newPlayer/spear.png')
sprites.player.bomb = love.graphics.newImage('sprites/player/bomb.png')
sprites.player.jetpack = love.graphics.newImage('sprites/newPlayer/jetpack.png')
sprites.player.aquaPack = love.graphics.newImage('sprites/newPlayer/aquapack.png')

sprites.player.newPlayer = love.graphics.newImage('sprites/newPlayer/newPlayer.png')

-- Images for everything relating to the environment and levels
sprites.environment = {}
sprites.environment.bg = love.graphics.newImage('sprites/environment/bg.png')
sprites.environment.wall = love.graphics.newImage('sprites/environment/wall.png')
sprites.environment.waterSheet = love.graphics.newImage('sprites/environment/waterSheet.png')
sprites.environment.rockySurface = love.graphics.newImage('sprites/environment/rockySurface.png')
sprites.environment.crack = love.graphics.newImage('sprites/environment/crack.png')
sprites.environment.breakParticle = love.graphics.newImage('sprites/environment/breakParticle.png')
sprites.environment.vine = love.graphics.newImage('sprites/environment/vine.png')

-- Images for enemies
sprites.enemies = {}
sprites.enemies.flyerBody = love.graphics.newImage('sprites/enemies/flyerBody.png')
sprites.enemies.flyerEye = love.graphics.newImage('sprites/enemies/flyerEye.png')
sprites.enemies.flyerWing1 = love.graphics.newImage('sprites/enemies/flyerWing1.png')
sprites.enemies.flyerWing2 = love.graphics.newImage('sprites/enemies/flyerWing2.png')
sprites.enemies.spikeBody = love.graphics.newImage('sprites/enemies/spikeBody.png')
sprites.enemies.spikeProj = love.graphics.newImage('sprites/enemies/spikeProj.png')
sprites.enemies.starfish = love.graphics.newImage('sprites/enemies/starfish.png')
sprites.enemies.evilBubble = love.graphics.newImage('sprites/enemies/evilBubble.png')
sprites.enemies.bossBody = love.graphics.newImage('sprites/enemies/bossBody.png')
sprites.enemies.bigBossEye = love.graphics.newImage('sprites/enemies/bigBossEye.png')
sprites.enemies.egg = love.graphics.newImage('sprites/enemies/egg.png')

-- Images for items
sprites.pickups = {}
sprites.pickups.health = love.graphics.newImage('sprites/items/healthPickup.png')
sprites.pickups.item = love.graphics.newImage('sprites/items/itemPickup.png')
sprites.pickups.pickup_back = love.graphics.newImage('sprites/items/pickup_back.png')
sprites.pickups.blaster = love.graphics.newImage('sprites/items/blaster.png')
sprites.pickups.rocketLauncher = love.graphics.newImage('sprites/items/rocketLauncher.png')
sprites.pickups.spearGun = love.graphics.newImage('sprites/items/spearGun.png')
sprites.pickups.aquaPack = love.graphics.newImage('sprites/items/aquaPack.png')

-- Individual blob shapes for drawing fire
sprites.fire = {}
sprites.fire.f1 = love.graphics.newImage('sprites/fire/fire_1.png')
sprites.fire.f2 = love.graphics.newImage('sprites/fire/fire_2.png')
sprites.fire.f3 = love.graphics.newImage('sprites/fire/fire_3.png')
sprites.fire.f4 = love.graphics.newImage('sprites/fire/fire_4.png')
sprites.fire.f5 = love.graphics.newImage('sprites/fire/fire_5.png')

-- Images for UI
sprites.ui = {}
sprites.ui.sound = love.graphics.newImage('sprites/ui/sound.png')
sprites.ui.github = love.graphics.newImage('sprites/ui/github.png')
