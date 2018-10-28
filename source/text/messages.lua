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

messages.failedLoad = {
  "No save file found.",
}

messages.intro = {
  "8-19-2049              \n"
  .. "St. Louis, Missouri, United States of America              \n\n"
  .. "Meteor has touched down with Earth's surface."
}

messages.tutorial = {
  "Use <W><A><S><D> to move.\nUse the mouse to look around.",
}
