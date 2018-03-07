function getGlobals()
  require("source/global/utilities")
  require("source/global/collision_classes")
  require("source/global/gameState")
  getCollisionClasses()

  Camera = require("source/libraries/hump/camera")
  vector = require("source/libraries/hump/vector")

  require("source/player")
  require("source/weapon")
  require("source/pickup")
  require("source/enemies/enemy")

  require("source/environment/explosion")

  require("source/cam")
  require("source/fonts")

  require("source/ui/messages")
  require("source/ui/scrollText")
  require("source/ui/textBox")

  sti = require("source/libraries/sti")
  require("source/levels/map_loader")
  loadMaps()
end
