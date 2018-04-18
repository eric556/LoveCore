
GAME_TO_LOAD = "sticks"

currentGame = {}
function loadGame(name)  -- Loads a minigame
    local path = "minigames/" .. name
    currentGame = require(path .. "/main")
    currentGame:load()
end

function love.load()
    loadGame(GAME_TO_LOAD)
end

function love.update(dt)
    if currentGame.update then
        currentGame:update(dt)
    end
end

function love.draw()
    if currentGame.draw then
        currentGame:draw()
    end
end

function love.focus(bool)
    if currentGame.focus then
        currentGame:focus(bool)
    end
end

function love.keypressed(key, unicode)
    if currentGame.keypressed then
        currentGame:keypressed(key, unicode)
    end
end

function love.keyreleased(key)
    if currentGame.keyreleased then
        currentGame:keyreleased(key)
    end
end

function love.mousepressed(x, y, button)
    if currentGame.mousepressed then
        currentGame:mousepressed(x, y, button)
    end
end

function love.mousereleased(x, y, button)
    if currentGame.mousereleased then
        currentGame:mousereleased(x, y, button)
    end
end

function love.quit()
    if currentGame.quit then
        currentGame:quit()
    end
end
