-- main.lua
-- EarthBound-like RPG - Main entry point
-- No OOP, pure procedural Lua + LÖVE2D

require("sprites")
require("player")
require("input")
require("map")

-- Game state
game = {
    screen_width = 320,
    screen_height = 240,
    scale = 3
}

function love.load()
    -- Pixel-perfect rendering
    love.graphics.setDefaultFilter("nearest", "nearest")

    -- Set window size (scaled up for visibility)
    love.window.setMode(
        game.screen_width * game.scale,
        game.screen_height * game.scale
    )
    love.window.setTitle("RPG")

    -- Initialize systems
    sprites_init()
    map_init()
    player_init()
end

function love.update(dt)
    input_update()
    player_update(dt)
end

function love.draw()
    -- Scale everything up
    love.graphics.push()
    love.graphics.scale(game.scale, game.scale)

    -- Draw in order: map, player, ui
    map_draw()
    player_draw()

    love.graphics.pop()
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end
