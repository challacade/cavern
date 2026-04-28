-- LÖVE configuration for Cavern.
--
-- The bulk of the game's window setup (dynamic scaling against the user's
-- desktop resolution) is performed in source/startup/startup.lua. This file
-- exists so web builds (love.js) have an initial canvas size, since web has
-- no desktop to query.

function love.conf(t)
    t.identity = "cavern"
    t.version  = "11.4"
    t.console  = false

    -- Native game resolution. On desktop, startup.lua will resize the window
    -- to fit the user's screen immediately after launch.
    t.window.title      = "CAVERN"
    t.window.width      = 1152
    t.window.height     = 768
    t.window.resizable  = false
    t.window.borderless = false
    t.window.fullscreen = false
    t.window.vsync      = 1
end
