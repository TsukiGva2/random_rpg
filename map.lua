-- map.lua
-- Simple test map with origin reference
require("tileset")

local map = {
    -- Row 1: Thick Forest Border (Top)
    {TILE_PINE, TILE_PINE,         TILE_PINE,           TILE_PINE,          TILE_PINE,          TILE_PINE,           TILE_PINE,          TILE_PINE},
    {TILE_PINE, TILE_GRAY_BRICK,   TILE_GRAY_BRICK,     TILE_DUNGEON_ENTRY, TILE_GRAY_BRICK,    TILE_GRAY_BRICK,     TILE_GRAY_BRICK,    TILE_PINE},
    {TILE_PINE, TILE_GRASS,        TILE_GRASS_1,        TILE_STAIRS_DOWN,   TILE_GRASS,         TILE_SIGN,           TILE_GRASS_2,       TILE_PINE},
    {TILE_PINE, TILE_BEAST,        TILE_GRASS,          TILE_GRASS,         TILE_GRASS_3,       TILE_GRASS,          TILE_LAKE_WATER_M2, TILE_LAKE_WATER_T2},
    {TILE_PINE, TILE_CHEST_CLOSED, TILE_GRASS_ROCKS,    TILE_GRASS,         TILE_GRASS,         TILE_LAKE_WATER_M1,  TILE_LAKE_WATER_M2, TILE_LAKE_WATER_M3},
    {TILE_PINE, TILE_GRASS,        TILE_GRASS,          TILE_GRASS,         TILE_GRASS,         TILE_LAKE_WATER_B1,  TILE_LAKE_WATER_B2, TILE_LAKE_WATER_B3},
    {TILE_PINE, TILE_PINE,         TILE_PINE,           TILE_PINE,          TILE_PINE,          TILE_PINE,           TILE_PINE,          TILE_PINE}
}

function map_init()
    tileset_init()
end

function map_draw()
    -- Draw background
    love.graphics.setColor(MAP_BG_COLOR)
    love.graphics.rectangle("fill", 0, 0, game.screen_width, game.screen_height)

    -- Reset color
    love.graphics.setColor(1, 1, 1)

    for y, row in ipairs(map) do
        for x, tile in ipairs(row) do
            love.graphics.draw(
                tileset, tiles[tile],
                (x-1) * TILE_SIZE, (y-1) * TILE_SIZE
            )
        end
    end
end
