-- Scroll handles all text that shows text letter-by-letter

scroll = {}

scroll.text = ""         -- Text currently on screen
scroll.fullMessage = ""  -- Full message that will be displayed
scroll.messageObj = nil  -- Message object pulled from messages.lua
scroll.charTimer = 0     -- Timer until next letter is displayed
scroll.textSpeed = 0.025 -- Display a new character every ____ seconds
scroll.messageNum = 1    -- Which string from the message object
scroll.charNum = 0       -- Which character of the full message we're on

function scroll:showMessage(m)

  -- Sets the first set of text for the message
  self.fullMessage = messages[m][1]
  self.text = ""

  self.messageNum = 1
  self.charNum = 0
  self.messageObj = messages[m]

  -- The messages table contains other tables, each containing a set of strings
  -- which will be displayed in order to the text window.

end

function scroll:update(dt)

  if self.messageObj ~= nil then
    while self.messageNum <= #self.messageObj do

      if self.fullMessage == "" then
        self.fullMessage = self.messageObj[self.messageNum]
      end

      if self.charNum < string.len(self.fullMessage) then
        self.charTimer = updateTimer(self.charTimer, dt)
        if self.charTimer == 0 then
          self.charNum = self.charNum + 1
          self.text = string.sub(self.fullMessage, 1, self.charNum)

          self.charTimer = self.textSpeed

          -- an "@" represents a spot to wait longer to display the next letter
          -- Wait 30 times longer than normal, and replace the @ with a space
          -- If the current letter is a comma, wait only slightly longer
          local nextLetter = string.sub(self.fullMessage, self.charNum+1, self.charNum+1)
          local curLetter = string.sub(self.fullMessage, self.charNum, self.charNum)
          if nextLetter == "@" then

            -- Wait longer
            self.charTimer = self.textSpeed * 30

            -- replace the @ with a space
            self.fullMessage = string.sub(self.fullMessage, 1, self.charNum) ..
              " " .. string.sub(self.fullMessage, self.charNum+2,
                string.len(self.fullMessage))

          end
          if curLetter == "," then
            self.charTimer = self.textSpeed * 15
          end

          -- The "string.sub" will get the latest character.
          -- The "string.byte" will convert that character into an integer
          -- that represents its ASCII equivalent
          -- All ASCII characters greater than 32 (visible characters) will
          -- play the text sound effect
          if string.byte( string.sub(self.text, self.charNum, self.charNum) ) > 32 then
            soundManager:play("text")
          end

        end
      else
        if love.keyboard.isDown("space","return", 'w', 'a', 's', 'd') or love.mouse.isDown(1,2) then
          self.text = ""
          self.fullMessage = ""
          self.charNum = 0
          self.messageNum = self.messageNum + 1
        end
      end

      return
    end

    self.messageObj = nil

  end

end
