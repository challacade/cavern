-- This table contains words that will be displayed
-- in the credits room
credits = {}
credits.bottom = 10112

-- Words follow this format:
-- { Word Text, X position, Y position, Font }

-- By default, font will be fonts.credits.word unless
-- specified otherwise

-- X position doesn't use a position value, but it has
-- 3 options: "center", "left", or "right". Items in
-- the credits will either be centered, or put into a
-- left and right column.

-- Y position is the number of pixels from the bottom
-- Example: if Y position was 100, text would be
-- displayed at credits.bottom - 100

table.insert(credits, {"Hello World!", "center", 0})

function credits:draw()

  -- Only draw if we are in rmCredits
  if gameState.room == "rmCredits" then
    for _,w in ipairs(self) do

      love.graphics.setColor(1, 1, 1, 1)

      local text = w[1]
      local x = 384
      local y = credits.bottom - w[3]
      local width = 1792

      if w[2] ~= "center" then
        width = width / 2
      end

      if w[2] == "right" then
        x = 1280
      end

      love.graphics.printf(text, x, y, width, "center")

    end
  end

end
