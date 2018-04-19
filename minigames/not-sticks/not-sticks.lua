
local NotSticks = {}

function NotSticks:load(world)
    self.world = world
    -- Load sprite sheet and create quads
    self.sprite = love.graphics.newImage("minigames/not-sticks/assets/not-stick.png")
    self.variant = {
        love.graphics.newQuad(0, 0, 32, 32, self.sprite:getDimensions())
    }

    -- Create the not-sticks
    self.notStickID = 0
    self.notSticks = {}
    self.max = 10
    math.randomseed(os.time())
end


function NotSticks:update(dt)
    width, height = love.graphics.getDimensions()
    while not (self.max == #self.notSticks) do
        local newNotStick = {}
        newNotStick.id = self.notStickID
        newNotStick.x = math.random(32, width - 64)
        newNotStick.y = math.random(32, height - 64)
        newNotStick.variant = math.random(1, #self.variant)
        -- Physics part
        newNotStick.b = love.physics.newBody(self.world, newNotStick.x, newNotStick.y, "static")
        newNotStick.s = love.physics.newRectangleShape(32, 32)
        newNotStick.f = love.physics.newFixture(newNotStick.b, newNotStick.s)
        newNotStick.f:setUserData(newNotStick.id)
        table.insert(self.notSticks, newNotStick)

        self.notStickID = self.notStickID + 1
    end
end

function NotSticks:draw()
    for _, stick in pairs(self.notSticks) do
        love.graphics.draw(self.sprite, self.variant[stick.variant], stick.x, stick.y)
    end
end

function NotSticks:remove(notStickID)
    local removed = false
    local i = 1
    while self.notSticks[i] and not removed do
        if self.notSticks[i].id == notStickID then
            table.remove(self.notSticks, i)
            removed = true
        end
        i = i + 1
    end
end

return NotSticks