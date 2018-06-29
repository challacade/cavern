-- Stores global information about the player's progress
gameState = {}
gameState.player = {}
gameState.pickups = {}

-- State stores if update functions should occur
gameState.state = 1

-- Player information
gameState.player.x = 0
gameState.player.y = 0
gameState.player.maxHealth = 20

-- Which pickups have been obtained
gameState.pickups.blaster = false
gameState.pickups.rocket = false
gameState.pickups.harpoon = false
gameState.pickups.aquaPack = false
gameState.pickups.health1 = false
gameState.pickups.health2 = false
