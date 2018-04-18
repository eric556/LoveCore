--[[
    Player class for handling user input and player drawing
]]

local Player = {}

function Player:load(world)
    self.world = world
    self.sprite = love.graphics.newImage("minigames/sticks/assets/player.png")
    self.currentSprite = 1
    self.spriteTimer = 0
    self.variant = {
        love.graphics.newQuad(0, 0, 32, 32, self.sprite:getDimensions()),
        love.graphics.newQuad(32, 0, 32, 32, self.sprite:getDimensions())
    }

    self.score = 0

    -- Movement
    self.x = 0
    self.y = 0
    self.movementSpeed = 500
    self.facing = 1

    -- Physics
    self.b = love.physics.newBody(self.world, self.x, self.y, "dynamic")
    self.s = love.physics.newRectangleShape(32, 32)
    self.f = love.physics.newFixture(self.b, self.s)
    self.f:setUserData("Player")
end

function Player:update(dt)

    local dx = 0  -- Change in x
    local dy = 0  -- Change in y

    if love.keyboard.isDown("s") then
        if love.keyboard.isDown("d") then
            dx = math.sqrt((self.movementSpeed * self.movementSpeed)/2)
            dy = math.sqrt((self.movementSpeed * self.movementSpeed)/2)
        elseif love.keyboard.isDown("a") then
            dx = -math.sqrt((self.movementSpeed * self.movementSpeed)/2)
            dy = math.sqrt((self.movementSpeed * self.movementSpeed)/2)
        else
            dy = self.movementSpeed
        end
    elseif love.keyboard.isDown("w") then
        if love.keyboard.isDown("d") then
            dx = math.sqrt((self.movementSpeed * self.movementSpeed)/2)
            dy = -math.sqrt((self.movementSpeed * self.movementSpeed)/2)
        elseif love.keyboard.isDown("a") then
            dx = -math.sqrt((self.movementSpeed * self.movementSpeed)/2)
            dy = -math.sqrt((self.movementSpeed * self.movementSpeed)/2)
        else
            dy = -self.movementSpeed
        end
    elseif love.keyboard.isDown("d") then
        dx = self.movementSpeed
    elseif love.keyboard.isDown("a") then
        dx = -self.movementSpeed
    end

    -- Update x and y
    self.x = dx * dt + self.x
    self.y = dy * dt + self.y
    -- Move the physics body
    self.b:setX(self.x)
    self.b:setY(self.y)

    if dx ~= 0 or dy ~= 0 then
        if dx > 0 then
            if self.facing == -1 then
                self.facing = 1
                self.x = self.x - 32
            end
        elseif dx < 0 then
            if self.facing == 1 then
                self.facing = -1
                self.x = self.x + 32
            end
        end

        self.spriteTimer = self.spriteTimer + dt
        if self.spriteTimer > 0.25 then
            self.spriteTimer = self.spriteTimer - 0.25
            if self.currentSprite == #self.variant then
                self.currentSprite = 1
            else
                self.currentSprite = self.currentSprite + 1
            end
        end
    end
end

function Player:draw()
    love.graphics.draw(self.sprite, self.variant[self.currentSprite], self.x, self.y, 0, self.facing, 1)
    love.graphics.print("Current Score: "..self.score, x, y)
end

return Player