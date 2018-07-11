blasts = {}

function spawnBlast(x, y, size, color, time, rev)
	blast = {}
	blast.x = x
	blast.y = y
	blast.color = color
	blast.radius = 1
	blast.max_radius = size
	blast.time = time
	blast.timer = time + 1
  blast.rev = rev or false
	blast.dead = false
  blast.maxAlpha = 0.706
	blast.alpha = blast.maxAlpha
	blast.state = 0
  
  -- If the blast should happen in reverse
  if rev then
    blast.radius = size
    blast.max_radius = 1
    blast.maxAlpha = 0.2
    blast.alpha = 0
    blast.revTimer = size/2
  end

	function blast:update(dt, i)
		self.timer = updateTimer(self.timer, dt)
		
    if self.timer == 0 then
			self.dead = true
		end

    local max = self.max_radius
    local maxAlph = self.maxAlpha

		if self.state == 0 then
			
			flux.to(self, self.time, { radius = max })
      
      if self.rev == false then
        -- Normal blast, fades out
        flux.to(self, self.time, { alpha = 0 })
      else
        -- Reverse blast, fade in, then out
        flux.to(self, self.time/4, { alpha = maxAlph })
      end
			
      self.state = 1
		end
    
    if self.rev and self.alpha == maxAlph then
      flux.to(self, self.time/2, { alpha = 0 })
    end
    
	end
	
  table.insert(blasts, blast)

end

function blasts:update(dt)
	for i,w in ipairs(blasts) do
		w:update(dt, i)
	end

	local i = table.getn(blasts)
	while i > 0 do
		if blasts[i].dead == true then
			table.remove(blasts, i)
		end
		i = i - 1
	end
end

function blasts:draw()
	for _,e in ipairs(blasts) do
    local r, g, b = unpack(e.color)
		love.graphics.setColor(r, g, b, e.alpha)
		love.graphics.circle("fill", e.x, e.y, e.radius, math.ceil(e.radius/2))
	end
end
