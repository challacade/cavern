-- This "fires" table contains every particle of fire currently in the game
-- The illusion of fire is made by spawning many small blob-shaped sprites
-- that move, change color, and fade away
fires = {}

function fires:spawnFire(x, y, life, dir, scale, off, speed, smoke, start_alpha)

  -- p is a single fire particle
	local p = {}
	p.width = 32
	p.height = 32

	p.x = x - p.width/2
	p.y = y - p.height/2

	p.speed = speed or 60
	p.smoke = smoke or false
	p.spr_rot = math.random(-3, 2) + math.random() -- 0 to pi radians

  -- sets a random blob sprite for the fire particle
	local spriteint = math.random(1, 5)
	p.sprite = nil
	if spriteint == 1 then
		p.sprite = sprites.fire.f1
	elseif spriteint == 2 then
		p.sprite = sprites.fire.f2
	elseif spriteint == 3 then
		p.sprite = sprites.fire.f3
	elseif spriteint == 4 then
		p.sprite = sprites.fire.f4
	elseif spriteint == 5 then
		p.sprite = sprites.fire.f5
	end

	p.dead = false              -- if the particle should be destroyed
	p.max_life = life           -- time the particle is visible
	p.life = p.max_life         -- current timer counting down
	p.scale = scale             -- size of the particle
	p.front = front or false    -- used for draw order (drawn sooner or later)
	p.direction = dir or vector(0, -1) -- direction the particle will move

	if dir ~= nil then
    -- set the direction of the particle
		p.direction = dir:normalized()

    -- This section uses the offset parameter to move the starting position
    -- of the particle slightly, based on the direction the particle moves.
    -- For example, if the direction was straight up, the particle would be
    -- offset randomly to the left or right.
		local o = off or 15
		local offset = math.random(-1 * o, o)
		local randrot = math.random(-3, 2) + math.random()
		local perp_vec = p.direction:rotated(randrot) * offset
		local ox, oy = perp_vec:unpack()
		p.x, p.y = p.x + ox, p.y + oy
	end

  -- Gives the particle a bit of random movement by slightly changing its
  -- direction. Multi is used to ensure there is an equal amount of clockwise
  -- rotation to counterclockwise.
	local multi = -1
	if table.getn(fires) % 2 == 0 then
		multi = 1
	end
	p.direction:rotateInplace(multi * math.random()/4)
	p.direction = p.direction * 3

	p.start_alpha = start_alpha or 0.188
	p.alpha = start_alpha or 0.188
	--p.scale = 2
	p.color = {1, 1, 1}
	if p.smoke == true then
		p.color = {0.471, 0.471, 0.471}
	end

	function p:update(dt)
		self.life = updateTimer(self.life, dt)
		--if self.life > (self.max_life/6)*5 then
			--p.color = {1, 1, 1}
		if self.life > (self.max_life/6)*5 then
			self.color = {1, 0.988, 0.757}
		elseif self.life > (self.max_life/6)*4 then
			self.color = {1, 0.788, 0.302}
		elseif self.life > (self.max_life/6)*2 then
			self.color = {1, 0.635, 0.176}
		elseif self.life > (self.max_life/6) then
			self.color = {1, 0.569, 0.098}
		else
			self.color = {1, 1, 1}
		end

    -- tints the fire to be smoke
		if self.smoke == true then
			self.color = {0.471, 0.471, 0.471}
    end

		if p.start_alpha == 0.188 then
			if self.life > 0.75 then
				self.alpha = p.start_alpha
			else
				self.alpha = self.life/4
			end
		else
			if self.life > 0.75 then
				self.alpha = p.start_alpha
			else
				self.alpha = self.life/9.75
			end
		end

		local dx, dy = self.direction:unpack()
		self.x = self.x + (dx * self.speed * dt)
		self.y = self.y + (dy * self.speed * dt)
		if self.alpha < 0.001 then
			self.dead = true
		end
	end

	table.insert(fires, p)
end

function fires:update(dt) do

	for i,f in ipairs(fires) do
		f:update(dt)
	end

	-- Iterate through all fires in reverse to remove dead ones
  for i=#fires,1,-1 do
    if fires[i].dead then
      table.remove(fires, i)
    end
  end

end

function fires:draw()

	for i,f in ipairs(fires) do
		love.graphics.setColor(f.color[1], f.color[2], f.color[3], f.alpha)
    love.graphics.draw(f.sprite, f.x+f.width/2, f.y+f.height/2, f.spr_rot, f.scale or 1, f.scale or 1, f.sprite:getWidth()/2, f.sprite:getHeight()/2)
	end

end
end
