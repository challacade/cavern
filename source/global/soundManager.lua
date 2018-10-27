-- This table is used to play sounds and music.
-- Use this table's functions so that it can check
-- whether or not the sound file should actually
-- be played (it checks if sound is turned off).

soundManager = {}
soundManager.music = sounds.music.cavern -- replace with menu music
soundManager.volume = 1 -- volume of the music
soundManager.fading = false -- volume will fade down if true

-- Used for the rooms leading up to the boss
soundManager.danger = false

-- Used to tell if the ending music has started
soundManager.ending = false

-- Use for Sound Effects
function soundManager:play(snd)

  if soundOn then
    sounds[snd]:play()
  end

end

function soundManager:startMusic(song)

  if song ~= nil then
    self.music = sounds.music[song]
  end

  if soundOn then
    self.fading = false
    self.volume = 1
    self.music:setVolume(self.volume)

    if song ~= "ending" and song ~= "intro" then
      self.music:setLooping(true)
    else
      self.music:setLooping(false)
    end

    love.audio.play(self.music)
  end

  self.danger = false

end

function soundManager:musicFade()
  self.fading = true
end

function soundManager:update(dt)
  if self.fading then
    self.volume = self.volume - dt -- will take 1 second to fade out
    if self.volume < 0 then
      self.volume = 0
      self.fading = false
      love.audio.stop(self.music)
    end
    self.music:setVolume(self.volume)
  end
end
