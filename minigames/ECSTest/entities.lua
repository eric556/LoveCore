local Entities = {
    {
        position = {
            x = 0,
            y = 0
        },
        size = {
            w = love.graphics.getWidth(),
            h = 10
        },
        color =  {
            r = 0,
            g = 0,
            b = 255,
            a = 255
        },
        bound = {
            type = "box",
            w = love.graphics.getWidth(),
            h = 10
        },
        id = 100
    },
    {
        position = {
            x = 0,
            y = love.graphics.getHeight() - 10
        },
        size = {
            w = love.graphics.getWidth(),
            h = 10
        },
        color = {
            r = 0,
            g = 0,
            b = 255,
            a = 255
        },
        bound = {
            type = "box",
            w = love.graphics.getWidth(),
            h = 10
        },
        id = 101
    },
    {
        position = {
            x = 0,
            y = 10
        },
        size = {
            w = 10,
            h = love.graphics.getHeight() - 20
        },
        color = {
            r = 0,
            g = 0,
            b = 255,
            a = 255
        },
        bound = {
            type = "box",
            w = 10,
            h = love.graphics.getHeight() - 20
        },
        id = 102
    },
    {
        position = {
            x = love.graphics.getWidth() - 10,
            y = 10
        },
        size = {
            w = 10,
            h = love.graphics.getHeight() - 20
        },
        color = {
            r = 0,
            g = 0,
            b = 255,
            a = 255
        },
        bound = {
            type = "box",
            w = 10,
            h = love.graphics.getHeight() - 20
        },
        id = 103
    }
}

return Entities