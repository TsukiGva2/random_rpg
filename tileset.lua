-- tileset.lua
-- Tile loading and handling

local __c=0
local function iota()
    __c = __c + 1
    return __c
end

-- Tile mappings: Name -> Number
TILE_SOLID_BLOCK    = iota()
TILE_YELLOW_BRICK   = iota()
TILE_HARD_BLOCK     = iota()
TILE_GRAY_BRICK     = iota()
TILE_SOLID_BROWN    = iota()
TILE_HOUSE_BRICK    = iota()
TILE_GRASS          = iota()
TILE_SAPLING        = iota()
TILE_LAKE_WATER_T1  = iota()
TILE_LAKE_WATER_T2  = iota()
TILE_LAKE_WATER_T3  = iota()
TILE_CASTLE_BRICK   = iota()
TILE_CASTLE_TOWER   = iota()
TILE_CASTLE_TOWER_F = iota()
TILE_SIGN           = iota()
TILE_PALM_TREE      = iota()
TILE_LAKE_WATER_M1  = iota()
TILE_LAKE_WATER_M2  = iota()
TILE_LAKE_WATER_M3  = iota()
TILE_GATE           = iota()
TILE_GATE_DOOR      = iota()
TILE_DRY_SAPLING    = iota()
TILE_GRAVE          = iota()
TILE_TOMBSTONE      = iota()
TILE_LAKE_WATER_B1  = iota()
TILE_LAKE_WATER_B2  = iota()
TILE_LAKE_WATER_B3  = iota()
TILE_BLACK          = iota()
TILE_PINE           = iota()
TILE_STONES_PINK    = iota()
TILE_STONES_PINK_T1 = iota()
TILE_STONES_PINK_T2 = iota()
TILE_STONES_PINK_T3 = iota()
TILE_WATER_1        = iota()
TILE_WATER_2        = iota()
_=iota() -- what are these two
TILE_GRASS_ROCKS    = iota()
TILE_STONES_PINK_B1 = iota()
TILE_STONES_PINK_B2 = iota()
TILE_STONES_PINK_B3 = iota()
TILE_WATER_3        = iota()
TILE_WATER_4        = iota()
TILE_PENCIL         = iota() -- what
TILE_HEXAGONS       = iota()
TILE_BEAST          = iota()
TILE_LEVER_L        = iota()
TILE_LEVER_R        = iota()
_=iota() -- dunno
TILE_DEEP_WATER     = iota()
TILE_KEY_LOCK       = iota()
TILE_DUNGEON_ENTRY  = iota()
TILE_GRAY_BRICK_U   = iota()
TILE_DUNGEON_WINDOW = iota()
TILE_LADDER         = iota()
TILE_STAIRS_UP      = iota()
TILE_STAIRS_DOWN    = iota()
TILE_CACTUS         = iota()
TILE_DEBRIS_JESUS   = iota()
TILE_BOULDER        = iota()
TILE_BOX            = iota()
TILE_BARREL         = iota()
TILE_CHEST_CLOSED   = iota()
TILE_CHEST_OPEN     = iota()
TILE_LAKE           = iota()
TILE_LAKE_GRASS_T1  = iota()
TILE_LAKE_GRASS_T2  = iota()
TILE_LAKE_GRASS_T3  = iota()
TILE_GRASS_1        = iota()
TILE_GRASS_2        = iota()
TILE_STONES_GRAY_T1 = iota()
TILE_STONES_GRAY_T2 = iota()
TILE_STONES_GRAY_T3 = iota()
TILE_LAKE_GRASS_M1  = iota()
TILE_LAKE_GRASS_M2  = iota()
TILE_LAKE_GRASS_M3  = iota()
TILE_GRASS_3        = iota()
TILE_GRASS_4        = iota()
TILE_STONES_GRAY_B1 = iota()
TILE_STONES_GRAY_B2 = iota()
TILE_STONES_GRAY_B3 = iota()
TILE_LAKE_GRASS_B1  = iota()
TILE_LAKE_GRASS_B2  = iota()
TILE_LAKE_GRASS_B3  = iota()
-- TODO: finishme

TILESET_FILE = 'images/tileset.bmp'

TILE_SIZE = 16

TILESET_ROWS = 16
TILESET_COLS = 8

tileset = nil
tiles = {}

-- Map colors
MAP_BG_COLOR = {0.2, 0.3, 0.2}

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

