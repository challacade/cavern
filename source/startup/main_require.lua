function getGlobals()
  require("source/global/utilities")
  require("source/global/collision_classes")
  require("source/global/gameState")
  getCollisionClasses()

  Camera = require("source/libraries/hump/camera")
  vector = require("source/libraries/hump/vector")
  flux = require("source/libraries/flux")

  require("source/player")
  require("source/weapon")
  require("source/pickup")
  require("source/enemies/enemy")

  require("source/environment/explosion")
  require("source/environment/breakable")

  require("source/global/cam")
  require("source/global/shake")

  require("source/startup/defineFonts")

  require("source/text/messages")
  require("source/text/scrollText")
  require("source/text/textBox")
  require("source/text/damage")

  sti = require("source/libraries/sti")
  require("source/levels/map_loader")
  loadMaps()
end
