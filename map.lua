-- map.lua
-- Simple test map with origin reference

-- Map colors
MAP_BG_COLOR = {0.2, 0.3, 0.2}

function map_init()
    -- Nothing to initialize for simple test map
end

function map_draw()
    -- Draw background
    love.graphics.setColor(MAP_BG_COLOR)
    love.graphics.rectangle("fill", 0, 0, game.screen_width, game.screen_height)

    -- Reset color
    love.graphics.setColor(1, 1, 1)

    for i, tile in ipairs(tiles) do
        love.graphics.draw(
            tileset, tile,
            (i * TILE_SIZE) % game.screen_width,
            i
        )
    end
end
