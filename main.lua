GAME_TO_LOAD = "ECSTest"
GAME_TO_LOAD_OVERRIDE = os.getenv("GAME_TO_LOAD_OVERRIDE")

currentGame = {}
function loadGame(name)  -- Loads a minigame
    local path = "minigames/" .. name
    print("loading game: " .. path);
    currentGame = require(path .. "/main")
    currentGame:load()
end

function love.load()
    if GAME_TO_LOAD_OVERRIDE then
        loadGame(GAME_TO_LOAD_OVERRIDE)
    else
        loadGame(GAME_TO_LOAD)
    end
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
