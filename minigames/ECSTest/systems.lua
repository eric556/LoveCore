local systems = {}

function systems.renderSystem(entity)
    if entity["position"] ~= nil and entity["color"] ~= nil then
        r, g, b, a = love.graphics.getColor()
        love.graphics.setColor(entity.color.r, entity.color.g, entity.color.b, entity.color.a)
        love.graphics.rectangle("fill", entity.position.x, entity.position.y, entity.size.w, entity.size.h)
        love.graphics.setColor(r, g, b, a)
    end
end

function systems.renderDebugSystem(entity)
    local debugSpacing = 15
    if entity["position"] ~= nil then
        local textpos = entity.position.y - debugSpacing
        love.graphics.print("Position: " .. entity.position.x .. ", " .. entity.position.y, entity.position.x, textpos)
        if entity["velocity"] ~= nil then 
            textpos = textpos - debugSpacing
            love.graphics.print("Velocity: " .. entity.velocity.x .. ", " .. entity.velocity.y, entity.position.x, textpos)
        end
        if entity["force"] ~= nil then
            textpos = textpos - debugSpacing            
            love.graphics.print("Force: " .. entity.force.x .. ", " .. entity.force.y, entity.position.x, textpos)
        end
        if entity["id"] ~= nil then
            textpos = textpos - debugSpacing
            love.graphics.print("ID: " .. entity.id, entity.position.x, textpos)
        end
    end
end

function systems.collisionSystem(entity, entities, dt)

    if systems.checkForFilters(entity, "position", "bound") then
        for k, v in pairs(entities) do
            if systems.checkForFilters(v, "position", "bound") and v.id ~= entity.id then
                local ePos = { x = entity.position.x, y = entity.position.y }

                if systems.checkForFilters(entity, "velocity") then
                    ePos.x = (entity.position.x + entity.velocity.x * dt)
                    ePos.y = (entity.position.y + entity.velocity.y * dt)
                end

                local vPos = { x = v.position.x, y = v.position.y}
                if systems.checkForFilters(v, "velocity") then
                    vPos.x = v.position.x + v.velocity.x * dt
                    vPos.y = v.position.y - v.velocity.y * dt
                end

                if ePos.x < vPos.x + v.bound.w and
                ePos.x + entity.bound.w > vPos.x and
                ePos.y < vPos.y + v.bound.h and
                ePos.y + entity.bound.h > vPos.y then
                    print("collision detected " .. entity.id .. " -> " .. v.id)
                end
            end
        end
    end
end

function systems.gavitySystem(entity)
    if systems.checkForFilters(entity, "force", "mass") then
        entity.force.y = entity.force.y + (entity.mass * -9.81)
    end
end

function systems.forceSystem(entity, dt)
    if systems.checkForFilters(entity, "velocity", "force", "mass", "acceleration") then
        entity.acceleration.x = entity.force.x / entity.mass
        entity.acceleration.y = entity.force.y / entity.mass

        entity.velocity.x = entity.velocity.x + entity.acceleration.x * dt
        entity.velocity.y = entity.velocity.y + entity.acceleration.y * dt
    end
end

function systems.movementSystem(entity, dt)
    if systems.checkForFilters(entity, "position", "velocity", "force", "mass") then
        entity.position.x = entity.position.x + entity.velocity.x * dt
        entity.position.y = entity.position.y - entity.velocity.y * dt
    end
end

function systems.checkForFilters(entity, ...)
    local toReturn = true
    for i = 1, select("#", ...) do
        toReturn = toReturn and (entity[select(i,...)] ~= nil)
    end
    return toReturn
end

return systems