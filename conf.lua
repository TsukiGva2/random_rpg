-- conf.lua
-- LÖVE2D configuration

function love.conf(t)
    t.title = "RPG"
    t.version = "11.4"

    t.window.width = 960
    t.window.height = 720
    t.window.resizable = false
    t.window.vsync = 1

    -- Disable unused modules for faster startup
    t.modules.joystick = false
    t.modules.physics = false
end
