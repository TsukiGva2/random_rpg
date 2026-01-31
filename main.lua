-- main.lua

require("sprites")
require("player")
require("input")
require("map")
require("graphics")

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
    graphics_init()
end

function love.update(dt)
    input_update()
    player_update(dt)
    graphics_update(dt)
end

function love.draw()
    -- Render to offscreen canvas
    graphics_begin()

    -- Draw in order: map, player, ui
    map_draw()
    player_draw()

    -- Apply CRT shader and draw to screen
    graphics_finish()
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    elseif key == "f1" then
        graphics_toggle()
    end
end
