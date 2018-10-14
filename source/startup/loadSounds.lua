sounds = {}

sounds.playerHurt = love.audio.newSource("sounds/player/playerHurt.wav", "static")

-- There are multiple laser sound effects, was originally planning to have
-- it randomly play one, but I decided I like laser2.wav the best.
sounds.laser = love.audio.newSource("sounds/player/laser2.wav", "static")
--sounds.laser = love.audio.newSource({"sounds/player/laser1.wav", "sounds/player/laser2.wav", "sounds/player/laser3.wav"}, "static")
sounds.bombShot = love.audio.newSource("sounds/player/bombShot.wav", "static")
sounds.explosion = love.audio.newSource("sounds/player/explosion.wav", "static")

sounds.enemyHurt = love.audio.newSource("sounds/enemies/enemyHurt.wav", "static")

sounds.text = love.audio.newSource("sounds/ui/text.wav", "static")

sounds.blip = love.audio.newSource("sounds/blip.wav", "static")
