-- Stores global information about the player's progress
gameState = {}
gameState.pickups = {}

-- State stores if update functions should occur
gameState.state = 1

-- Which pickups have been obtained
gameState.pickups.blaster = false
gameState.pickups.missile = false
gameState.pickups.harpoon = false
