
local Sticks = {}

function Sticks:load(world)
    self.world = world
    -- Load sprite sheet and create quads
    self.sprite = love.graphics.newImage("minigames/sticks/assets/stick.png")
    self.variant = {
        love.graphics.newQuad(0, 0, 32, 32, self.sprite:getDimensions())
    }

    -- Create the sticks
    self.stickID = 0
    self.sticks = {}
    self.max = 10
    math.randomseed(os.time())
end


function Sticks:update(dt)
    width, height = love.graphics.getDimensions()
    while not (self.max == #self.sticks) do
        local newStick = {}
        newStick.id = self.stickID
        newStick.x = math.random(32, width - 64)
        newStick.y = math.random(32, height - 64)
        newStick.variant = math.random(1, #self.variant)
        -- Physics part
        newStick.b = love.physics.newBody(self.world, newStick.x, newStick.y, "static")
        newStick.s = love.physics.newRectangleShape(32, 32)
        newStick.f = love.physics.newFixture(newStick.b, newStick.s)
        newStick.f:setUserData(newStick.id)
        table.insert(self.sticks, newStick)

        self.stickID = self.stickID + 1
    end
end

function Sticks:draw()
    for _, stick in pairs(self.sticks) do
        love.graphics.draw(self.sprite, self.variant[stick.variant], stick.x, stick.y)
    end
end

function Sticks:remove(stickID)
    local removed = false
    local i = 1
    while self.sticks[i] and not removed do
        if self.sticks[i].id == stickID then
            table.remove(self.sticks, i)
            removed = true
        end
        i = i + 1
    end
end

return Sticks