-- This table is used to play sounds and music.
-- Use this table's functions so that it can check
-- whether or not the sound file should actually
-- be played (it checks if sound is turned off).

soundManager = {}
soundManager.music = sounds.music.cavern -- replace with menu music
soundManager.volume = 1 -- volume of the music
soundManager.fading = false -- volume will fade down if true

-- Use for Sound Effects
function soundManager:play(snd)

  if soundOn then
    sounds[snd]:play()
  end

end

function soundManager:startMusic()

  if soundOn then
    self.fading = false
    self.volume = 1
    self.music:setVolume(self.volume)
    self.music:setLooping(true)
    love.audio.play(self.music)
  end

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
