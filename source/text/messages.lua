-- All messages that get displayed in a scroll

messages = {}

messages.blaster = {
  "You got the blaster!",
  "Use the mouse to aim, and\n<LEFT CLICK> to shoot!"
}
messages.blaster.img = sprites.pickups.blaster

messages.rocket = {
  "You got the Rocket Launcher!",
  "<LEFT CLICK> to launch a missile\nthat explodes upon impact,\ndealing massive damage.",
  "Press the <SPACEBAR> or scroll\nthe mouse wheel to switch\nyour equipped weapon."
}
messages.rocket.img = sprites.pickups.rocketLauncher

messages.harpoon = {
  "You got the Spear Gun!",
  "<LEFT CLICK> to shoot a spear,\neven while underwater.",
}
messages.harpoon.img = sprites.pickups.spearGun

messages.aquaPack = {
  "You got the Aqua Pack!",
  "Your suit is now capable of\ngoing underwater.",
}
messages.aquaPack.img = sprites.pickups.aquaPack

messages.health = {
  "You got a Health Upgrade!",
  "Your health has been restored,\nand your maximum health has\nincreased by 5.",
}
messages.health.img = sprites.pickups.health

messages.failedLoad = {
  "No save file found.",
}

messages.intro = {
  "1-31-2056              \n"
  .. "St. Louis, Missouri, United States of America     @\n\n"
  .. "Asteroid \"433 Eros\" has crashed into Earth approximately \n30 miles "
  .. "southwest of the city.@The impact has uncovered the\nentrance to a series"
  .. " of unexplored caves deep underground.      @\n\n"
  .. "It was discovered in the year 2053 that Eros was home to a\nnew form of "
  .. "life.@Movement has been detected beneath the\nsurface of the impact site,"
  .. " indicating that these alien\nlifeforms have migrated into the caves."
  .. "      @\n\n"
  .. "We are sending an expert in to investigate."

}

messages.tutorial = {
  "Use <W><A><S><D> to move.\nUse the mouse to look around.",
}
