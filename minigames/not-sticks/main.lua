local Game = {}

function Game:load(arg)
    circle = {}
    circle.x = 150			-- This will render the circle at 150px to the right along the x-axis.
    circle.y = 150			-- This will render the circle at 150px below along the y-axis.
    circle.speed = 500		-- This will give the circle a movement speed of 500.
 
    rect = {}
    rect.x = 300			-- This will render the rectangle at 300px to the right along the x-axis.
    rect.y = 150			-- This will render the rectangle at 150px below along the y-axis.
    rect.w = 100			-- This will render the rectangle with a width of 100px.
    rect.h = 100			-- This will render the rectangle with a height of 100px.
    rect.speed = 100		-- This will give the rectangle a movement speed of 100.
end
 
function Game:update(dt)
    if love.keyboard.isDown("d") then 				-- If player is holding down 'D',
	circle.x = circle.x + (circle.speed * dt)		-- Move circle to the right.
    end
 
    if love.keyboard.isDown("a") then 				-- If player is holding down 'A',
	circle.x = circle.x - (circle.speed * dt)		-- Move circle to the left.
    end
 
    if love.keyboard.isDown("w") then 				-- If player is holding down 'W',
	circle.y = circle.y - (circle.speed * dt)		-- Move circle upwards.
    end
 
    if love.keyboard.isDown("s") then 				-- If player is holding down 'S',
	circle.y = circle.y + (circle.speed * dt)		-- Move circle downwards.
    end
 
    if rect.x < circle.x then 					-- If the rect is to the left of the circle:
	rect.x = rect.x + (rect.speed * 2.5 * dt)		-- Rectangle moves towards the right.
    end
 
    if rect.x > circle.x then 					-- If the rect is to the right of the circle:
	rect.x = rect.x - (rect.speed * 2.5 * dt) 		-- Rectangle moves towards the left.
    end
 
    if rect.y < circle.y then 					-- If the rect is above the circle:
	rect.y = rect.y + (rect.speed * 2.5 * dt)		-- Rectangle moves downward.
    end
 
    if rect.y > circle.y then 					-- If the rect is below the circle:
	rect.y = rect.y - (rect.speed * 2.5 * dt)		-- Rectangle moves upward.
    end

    if love.keyboard.isDown("escape") then
        print("be that way then")
        love.event.quit() 
    end
end
 
function Game:draw()
    love.graphics.setColor(255, 0, 0)
    love.graphics.circle("fill", circle.x, circle.y, 50)
 
    love.graphics.setColor(0, 255, 0)
    love.graphics.rectangle("fill", rect.x, rect.y, rect.w, rect.h)
end

function Game:contact(player, stick, coll)
    print("collision!")
end

return Game