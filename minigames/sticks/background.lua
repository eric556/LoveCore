
local Background = {}

-- Loads assets and creates tiles
function Background:load()
    -- Load sprite sheet and create quads
    self.sprite = love.graphics.newImage("minigames/sticks/assets/grass.png")
    self.variant = {
        love.graphics.newQuad(0, 0, 32, 32, self.sprite:getDimensions()),
        love.graphics.newQuad(32, 0, 32, 32, self.sprite:getDimensions()),
        love.graphics.newQuad(64, 0, 32, 32, self.sprite:getDimensions())
    }

    -- Create the tiles
    self.tiles = {}
    width, height = love.graphics.getDimensions()
    math.randomseed(os.time())
    for x = 0, width / 32 do
        for y = 0, height / 32 do
            table.insert(self.tiles, {
                x * 32,  -- X position
                y * 32,  -- Y position
                math.random(1, #self.variant)  -- Variant of tile
            })
        end
    end
end

-- Draw the background onto the screen
function Background:draw()
    local x, y, variant
    for i in ipairs(self.tiles) do
        x, y = self.tiles[i][1], self.tiles[i][2]
        variant = self.tiles[i][3]  -- Variant of the tile
        love.graphics.draw(self.sprite, self.variant[variant], x, y)
    end
end

return Background