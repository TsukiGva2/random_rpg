-- input.lua
-- Input handling

-- Input state
input = {
    up = false,
    down = false,
    left = false,
    right = false,
    confirm = false,
    cancel = false
}

function input_update()
    -- Arrow keys
    input.up = love.keyboard.isDown("up", "w")
    input.down = love.keyboard.isDown("down", "s")
    input.left = love.keyboard.isDown("left", "a")
    input.right = love.keyboard.isDown("right", "d")

    -- Action buttons
    input.confirm = love.keyboard.isDown("z", "return")
    input.cancel = love.keyboard.isDown("x", "backspace")
end
