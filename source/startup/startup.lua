function startup()

  -- GAME WINDOW CONFIGURATION

  -- Window title
  love.window.setTitle("CAVERN")

  -- Window icon
  local icon = love.image.newImageData('sprites/newPlayer2/helmet.png')
  love.window.setIcon(icon)

  -- Game resolution
  gameWidth = 1152
  gameHeight = 768

  scale = 1 -- adjusts game window to screen size
  offset = 0.8 -- window size relative to scale

  local screen_width, screen_height = love.window.getDesktopDimensions()
  local w_scale = screen_width / gameWidth
  local h_scale = screen_height / gameHeight

  -- scale set to be the lesser of w_scale and h_scale
  -- this way, the game window will not ever exceed screen size
  if w_scale < h_scale then
    scale = w_scale
  else
    scale = h_scale
  end

  scale = scale * offset

  love.window.setMode(gameWidth * scale, gameHeight * scale, {fullscreen = false,
    fullscreentype = "desktop", resizable = false, borderless = false,
    vsync = true})


  -- GAME SETUP

  -- Physics setup
  -- Windfield is a library that makes LOVE's physics easier to work with
  -- https://github.com/SSYGEN/windfield
  local wf = require("source/libraries/windfield")
  world = wf.newWorld(0, 0, true) -- No gravity, bodies can sleep
  gravWorld = wf.newWorld(0, 1000, true)

  -- Global sound variable, game starts with it on
  soundOn = true

  -- Requires all global source files
  require("source/startup/main_require")
  getGlobals()

  -- Sets first map of the game
  changeToMap("rmMainMenu")

  -- Start the music!
  soundManager:startMusic("menu")
end

-- This function resets all values after the game is completed
function reinit()
  gameStateInit()
  player.weapon = 0
  player.health = gameState.player.maxHealth
end
