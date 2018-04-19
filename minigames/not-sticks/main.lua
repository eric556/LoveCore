Player = require("minigames/not-sticks/player")
NotSticks = require("minigames/not-sticks/not-sticks")
Background = require("minigames/not-sticks/background")

local Game = {}

function Game:load(arg)
    self.world = love.physics.newWorld(0, 0, false)

    Player:load(self.world)
    NotSticks:load(self.world)
    Background:load()
    self.world:setCallbacks(function (a, b, coll) self:contact(a, b, coll) end, nil, nil,  nil)
end

function love.keypressed(key, u)
    if key == "escape" then
        print("be that way then")
            love.event.quit() 
    end
 end

function Game:update(dt)
    Player:update(dt)
    NotSticks:update(dt)
    self.world:update(dt)
end

function Game:draw()
    Background:draw()
    NotSticks:draw()
    Player:draw()
end

function Game:contact(player, notStick, coll)
    NotSticks:remove(tonumber(notStick:getUserData()))
    Player.score = Player.score + 1
    notStick:destroy()
end

return Game
