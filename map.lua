-- map.lua
-- Simple test map with origin reference

-- Map colors
MAP_BG_COLOR = {0.2, 0.3, 0.2}
MAP_GRID_COLOR = {0.3, 0.4, 0.3}
MAP_ORIGIN_COLOR = {0.8, 0.2, 0.2}

-- Grid settings
GRID_SIZE = 16

function map_init()
    -- Nothing to initialize for simple test map
end

function map_draw()
    -- Draw background
    love.graphics.setColor(MAP_BG_COLOR)
    love.graphics.rectangle("fill", 0, 0, game.screen_width, game.screen_height)

    -- Draw grid for reference
    love.graphics.setColor(MAP_GRID_COLOR)
    for x = 0, game.screen_width, GRID_SIZE do
        love.graphics.line(x, 0, x, game.screen_height)
    end
    for y = 0, game.screen_height, GRID_SIZE do
        love.graphics.line(0, y, game.screen_width, y)
    end

    -- Draw origin marker (center of screen)
    local origin_x = game.screen_width / 2
    local origin_y = game.screen_height / 2

    love.graphics.setColor(MAP_ORIGIN_COLOR)
    -- Crosshair at origin
    love.graphics.line(origin_x - 8, origin_y, origin_x + 8, origin_y)
    love.graphics.line(origin_x, origin_y - 8, origin_x, origin_y + 8)
    -- Small circle at origin
    love.graphics.circle("line", origin_x, origin_y, 4)

    -- Reset color
    love.graphics.setColor(1, 1, 1)
end
