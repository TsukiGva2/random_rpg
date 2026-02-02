-- tileset.lua
-- Tile loading and handling

-- Tile mappings: Name -> Number

TILESET_FILE = 'images/tileset.bmp'

TILE_SIZE = 16

TILESET_ROWS = 16
TILESET_COLS = 8

tileset = nil
tiles = {}

function tileset_init()
    tiles_load()
end

function tiles_load()
    tileset = love.graphics.newImage(TILESET_FILE)

    local w, h = tileset:getDimensions()

    for i = 0, TILESET_ROWS - 1 do
        for j = 0, TILESET_COLS - 1 do
            table.insert(tiles, love.graphics.newQuad(
                j * TILE_SIZE, i * TILE_SIZE,
                TILE_SIZE, TILE_SIZE,
                w, h
            ))
        end
    end
end

