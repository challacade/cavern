-- This table is used to play sounds and music.
-- Use this table's functions so that it can check
-- whether or not the sound file should actually
-- be played (it checks if sound is turned off).

soundManager = {}

function soundManager:play(snd)
  
  sounds[snd]:play()
  
end
