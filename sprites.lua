-- sprites.lua
-- Spritesheet loading and animation handling
-- Spritesheets are 96x16 (6 frames of 16x16)
-- Frame order: idle, back_idle, left_walk, down_walk, up_walk, left_walk2

-- Sprite constants
SPRITE_SIZE = 16
SPRITE_COLS = 6

-- Frame indices (0-based for quad calculation)
FRAME_IDLE = 0
FRAME_BACK_IDLE = 1
FRAME_LEFT_WALK = 2
FRAME_DOWN_WALK = 3
FRAME_UP_WALK = 4
FRAME_LEFT_WALK2 = 5

-- All loaded spritesheets
spritesheets = {}

-- All quads for each spritesheet
sprite_quads = {}

function sprites_init()
    -- Load all character spritesheets
    sprites_load("camille", "images/camille.png")
    sprites_load("steve", "images/steve.png")
    sprites_load("alice", "images/alice.png")
    sprites_load("dave", "images/dave.png")
end

function sprites_load(name, path)
    local image = love.graphics.newImage(path)
    spritesheets[name] = image

    -- Create quads for each frame
    sprite_quads[name] = {}
    for i = 0, SPRITE_COLS - 1 do
        sprite_quads[name][i] = love.graphics.newQuad(
            i * SPRITE_SIZE, 0,
            SPRITE_SIZE, SPRITE_SIZE,
            image:getDimensions()
        )
    end
end

function sprites_draw(name, frame, x, y, flip_x)
    local image = spritesheets[name]
    local quad = sprite_quads[name][frame]

    if flip_x then
        -- Draw flipped horizontally
        love.graphics.draw(
            image, quad,
            x + SPRITE_SIZE, y,
            0,
            -1, 1
        )
    else
        love.graphics.draw(image, quad, x, y)
    end
end
