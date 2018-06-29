function getGlobals()
  require("source/startup/loadFonts")
  require("source/startup/loadSprites")

  require("scripts/libraries/Tserial")

  require("source/global/utilities")
  require("source/global/collision_classes")
  require("source/global/gameState")
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

  require("source/environment/particle")
  require("source/environment/explosion")
  require("source/environment/breakable")
  require("source/environment/water")
  require("source/environment/vine")
  require("source/environment/fire")
  require("source/environment/trail")
  require("source/environment/blast")

  require("source/global/cam")
  require("source/global/shake")

  require("source/text/messages")
  require("source/text/scrollText")
  require("source/text/textBox")
  require("source/text/damage")

  sti = require("source/libraries/sti")
  require("source/levels/map_loader")
  loadMaps()
end
