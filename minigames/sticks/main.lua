Player = require("minigames/sticks/player")
Sticks = require("minigames/sticks/sticks")
Background = require("minigames/sticks/background")

local Game = {}

function Game:load(arg)
    self.world = love.physics.newWorld(0, 0, false)

    Player:load(self.world)
    Sticks:load(self.world)
    Background:load()
    self.world:setCallbacks(function (a, b, coll) self:contact(a, b, coll) end, nil, nil,  nil)
end

function Game:update(dt)
    Player:update(dt)
    Sticks:update(dt)
    self.world:update(dt)
end

function Game:draw()
    Background:draw()
    Sticks:draw()
    Player:draw()
end

function Game:contact(player, stick, coll)
    Sticks:remove(tonumber(stick:getUserData()))
    Player.score = Player.score + 1
    stick:destroy()
end

return Game
