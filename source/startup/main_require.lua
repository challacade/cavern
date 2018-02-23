function getGlobals()
  require("source/global_functions")
  require("source/collision_classes")
  getCollisionClasses()

  Camera = require("source/libraries/hump/camera")
  require("source/libraries/hump/vector")

  require("source/player")
  require("source/weapon")
  require("source/enemies/enemy")

  require("source/cam")

  sti = require("source/libraries/sti")
  require("source/map_loader")
  loadMaps()
end
