trails = {}

function spawnTrail(id, max, width, color)
	trail = {}
	trail.id = id  -- used to tell which object to follow
	trail.max = max  -- length of the trail
	trail.width = width  -- width of the trail
	trail.color = color  -- color of the trail

	trail.points = {}
	trail.dead = false
	trail.updated = false

	trail.arc = {}
	trail.poly = {}
	trail.triangles = {}

	function trail:update(dt, wep)

		self.updated = true
		self.arc = {}

		local t = {}
		t.x = wep.physics.body:getX()
		t.y = wep.physics.body:getY()
		t.dir = nil

		if wep.moving == false then
			t.dir = wep.direct:normalized()
		else
			local vx, vy = wep.physics.body:getLinearVelocity()
			t.dir = vector(vx, vy):normalized()
		end

		table.insert(self.points, t)
	end

  table.insert(trails, trail)

end

function trails:update(dt)

  for _,t in ipairs(trails) do
		t.updated = false
	end

	local i = table.getn(trails)
	while i > 0 do
		if trails[i].dead == true then
			table.remove(trails, i)
		end
		i = i - 1
	end

end

-- Call this AFTER weapons get updated
-- This function handles what happens to the trail after the weapon is destroyed
function trails:fadeOut(dt)
	for _,t in ipairs(trails) do
		if t.updated == false then
			t.max = t.max - 1
			--create_poly(t)
			if t.max < 2 then
				t.dead = true
			end
		end
	end
end

function trails:draw()
	for _,t in ipairs(trails) do
		if table.getn(t.points) > 1 then
			local firstpt = table.getn(t.points) - t.max
			if firstpt < 1 then
				firstpt = 1
			end
      love.graphics.setColor(unpack(t.color))
      love.graphics.setLineWidth(t.width)
			love.graphics.line(t.points[firstpt].x, t.points[firstpt].y, t.points[table.getn(t.points)].x, t.points[table.getn(t.points)].y)
		end
	end
end
