fonts = {}

-- fonts.pickup = love.graphics.newFont(34 * scale)
fonts.pickup = love.graphics.newFont("fonts/russoone/RussoOne-Regular.ttf", 42 * scale)
fonts.damage = love.graphics.newFont("fonts/russoone/RussoOne-Regular.ttf", 42)
fonts.boss = love.graphics.newFont("fonts/russoone/RussoOne-Regular.ttf", 52 * scale)

-- Fonts used during the credits
fonts.credits = {}
fonts.credits.word = love.graphics.newFont("fonts/russoone/RussoOne-Regular.ttf", 48)
fonts.credits.title = love.graphics.newFont("fonts/russoone/RussoOne-Regular.ttf", 118)
fonts.credits.me = love.graphics.newFont("fonts/russoone/RussoOne-Regular.ttf", 56)

-- Fonts used for the Main Menu and Intro
fonts.menu = {}
fonts.menu.title = love.graphics.newFont("fonts/russoone/RussoOne-Regular.ttf", 146 * scale)
fonts.menu.button = love.graphics.newFont("fonts/russoone/RussoOne-Regular.ttf", 48 * scale)
fonts.menu.message = love.graphics.newFont("fonts/russoone/RussoOne-Regular.ttf", 32 * scale)
fonts.menu.intro = love.graphics.newFont("fonts/vt323/VT323-Regular.ttf", 42 * scale)

-- Misc fonts
fonts.misc = {}
fonts.misc.save = love.graphics.newFont("fonts/russoone/RussoOne-Regular.ttf", 36 * scale)
fonts.misc.tutorial = love.graphics.newFont("fonts/russoone/RussoOne-Regular.ttf", 49)
