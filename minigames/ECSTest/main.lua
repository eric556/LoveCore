local entities = require("minigames/TestGame/entities")
local systems = require("minigames/TestGame/systems")

local Game = {}

Game.done = false

local Window = {
    width = love.graphics.getWidth(),
    height = love.graphics.getHeight()
}

function Game:load(arg)
    for i=1,5 do        
        local ent = {
            position = {
                x = 10 + (i * 100),
                y = 100
            },
            velocity = {
                x = 0, 
                y = 0
            },
            acceleration = {
                x = 0,
                y = 0
            },
            size = {
                w = 10, 
                h = 10
            },
            color = {
                r = 255,
                g = 0,
                b = 10 + (i * 10),
                a = 255
            },
            force = {
                x = 0,
                y = 400
            },
            bound = {
                type = "box",
                w = 10,
                h = 10
            },
            mass = 1 * i,
            id = i
        }
        entities[#entities+1] = ent   
    end
end

function Game:update(dt)
    if love.keyboard.isDown( "up" ) then
        for k, v in pairs(entities) do
            systems.gavitySystem(v)
            systems.forceSystem(v,dt)
            systems.collisionSystem(v, entities, dt)            
            systems.movementSystem(v, dt)
        end
     end
end

function Game:draw()
    for k, v in pairs(entities) do
        systems.renderSystem(v)    
        systems.renderDebugSystem(v)    
    end
end

return Game