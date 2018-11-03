function getGlobals()
  require("source/libraries/slam")
  require("source/startup/loadFonts")
  require("source/startup/loadSprites")
  require("source/startup/loadSounds")

  require("source/libraries/Tserial")

  require("source/global/utilities")
  require("source/global/collision_classes")
  require("source/global/gameState")
  gameStateInit()

  require("source/global/saveGame")
  require("source/global/saveUtil")
  require("source/global/soundManager")
  getCollisionClasses()

  Camera = require("source/libraries/hump/camera")
  vector = require("source/libraries/hump/vector")
  flux = require("source/libraries/flux")
  anim8 = require("source/libraries/anim8")

  require("source/player")
  require("source/weapon")
  require("source/pickup")
  require("source/enemies/enemy")
  require("source/enemies/spikeProj")
  require("source/enemies/enemyProj")
  require("source/enemies/eye")
  require("source/enemies/egg")

  require("source/environment/particle")
  require("source/environment/explosion")
  require("source/environment/breakable")
  require("source/environment/water")
  require("source/environment/vine")
  require("source/environment/fire")
  require("source/environment/trail")
  require("source/environment/blast")

  require("source/global/shake")

  require("source/text/messages")
  require("source/text/scrollText")
  require("source/text/textBox")
  require("source/text/damage")
  require("source/text/credits")
  require("source/text/tutorial")

  require("source/ui/cam")
  require("source/ui/blackScreen")
  require("source/ui/flash")
  require("source/ui/mainMenu")

  require("source/levels/intro")
  require("source/levels/background")

  sti = require("source/libraries/sti")
  require("source/levels/map_loader")
  loadMaps()
end
