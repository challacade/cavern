-- When an enemy takes damage, it'll display the damage amount
damages = {}

function damages:spawnDamage(x, y, val, who)

	local damage = {}

  -- starting position of the damage text
  damage.x = x - 40
	if val < 10 then
		damage.x = damage.x + 11
	end
  damage.y = y

  -- Information for the bouncing tween used to animate the text
  damage.start_y = y
	damage.val = val * -1
	damage.jump_tween_x = nil
	damage.jump_tween_y = nil
	damage.alpha_tween = nil
	damage.alpha = 255
	damage.dead = false

  -- Random value determining how far left or right the text will bounce
	damage.rx = math.random(-70, 70)

	function damage:update()

		local function on_fade_complete()
			self.jump_tween_x = nil
			self.jump_tween_y = nil
			self.alpha_tween = nil
			self.dead = true
		end

		local function on_y_complete()
			local sy = self.start_y
			self.jump_tween_y = flux.to(self, 0.5, {y = sy}):ease("quadin")
			self.alpha_tween = flux.to(self, 0.5, {alpha = 0}):oncomplete(on_fade_complete):ease("cubicout")
		end

		if self.jump_tween_x == nil then
			local rx = self.x + self.rx
			self.jump_tween_x = flux.to(self, 1, {x = rx})
		end
		if self.jump_tween_y == nil then
			self.jump_tween_y = flux.to(self, 0.5, {y = y - 150}):oncomplete(on_y_complete):ease("quadout")
		end
	end

  table.insert(damages, damage)

end

function damages:update(dt)

  for i,d in ipairs(self) do
    d:update(dt)
  end

  -- Iterate through all damages in reverse to remove dead ones from table
  for i=#damages,1,-1 do
    if damages[i].dead then
      table.remove(weapons, i)
    end
  end

end

function damages:draw()
  for _,d in ipairs(damages) do
		love.graphics.setColor(255, 50, 50, d.alpha)
		--love.graphics.setFont(fonts.munro)
		love.graphics.print(d.val, d.x, d.y)
		love.graphics.setColor(255, 255, 255, 255)
	end
end
