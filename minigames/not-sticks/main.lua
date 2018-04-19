flux = require("minigames/not-sticks/lib/flux")

love.window.setMode(500, 500)

local Game = {}

function Game:load(arg)
    circle = {}
    circle.x = 150			-- This will render the circle at 150px to the right along the x-axis.
	circle.y = 150			-- This will render the circle at 150px below along the y-axis.
	circle.radius = 25
    circle.speed = 500		-- This will give the circle a movement speed of 500.
 
    rect = {}
    rect.x = 300			-- This will render the rectangle at 300px to the right along the x-axis.
    rect.y = 150			-- This will render the rectangle at 150px below along the y-axis.
    rect.w = 50			-- This will render the rectangle with a width of 100px.
    rect.h = 50			-- This will render the rectangle with a height of 100px.
	rect.speed = 100		-- This will give the rectangle a movement speed of 100.

	score = 0
	timeElapsed = 0
	nextAttackTime = 1
	timeBetweenAttacks = 1
	timeBetweenAttacksDecay = 0.02
	attackDuration = 0.5
	attackDurationDecay = 0.01
end
 
function Game:update(dt)
    local shouldDoAttack = false
    timeElapsed = timeElapsed + dt
    -- print("time elapsed: " .. timeElapsed .. " next attack time: " .. nextAttackTime)
    if timeElapsed > nextAttackTime then
      nextAttackTime = nextAttackTime + timeBetweenAttacks
      shouldDoAttack = true
    end

    if love.keyboard.isDown("d") then 
		circle.x = circle.x + (circle.speed * dt)	
    end
 
    if love.keyboard.isDown("a") then 		
		circle.x = circle.x - (circle.speed * dt)		
    end
 
    if love.keyboard.isDown("w") then 				
		circle.y = circle.y - (circle.speed * dt)		
    end
 
    if love.keyboard.isDown("s") then 
		circle.y = circle.y + (circle.speed * dt)		
    end

	if shouldDoAttack then
		shouldDoAttack = false
		
		attackCompletCallback = function()
			if rect.x == (circle.x - (rect.w / 2)) and rect.y == (circle.y - (rect.h / 2)) then
				self.load()
				print("too slow, they got you!")
			end
			score = score + 1
			print("SCORE: " .. score)
			timeBetweenAttacks = timeBetweenAttacks - timeBetweenAttacksDecay
        end

        local attackTargetX, attackTargetY = (circle.x - (rect.w / 2)), (circle.y - (rect.h / 2)) 
        flux.to(rect, attackDuration, { x = attackTargetX, y = attackTargetY }):ease("elasticin"):oncomplete(attackCompletCallback)
        attackDuration = attackDuration - attackDurationDecay
    end

    if love.keyboard.isDown("escape") then
        print("be that way then")
        love.event.quit() 
    end

    flux.update(dt)
end
 
function Game:draw()
    love.graphics.setColor(0, 255, 0)
	love.graphics.circle("fill", circle.x, circle.y, circle.radius)
	
	love.graphics.print("Current Score: " .. score, x, y)

    love.graphics.setColor(255, 0, 0)
	love.graphics.rectangle("fill", rect.x, rect.y, rect.w, rect.h)
	
end

function Game:contact(youHitMe, noYouHitME, collision)
    -- TODO 'real physics' https://love2d.org/wiki/Tutorial:Physics
    print("collision!") -- I don't know love physics yet
end

return Game