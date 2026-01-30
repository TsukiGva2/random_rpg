-- player.lua
-- Player state and movement

-- Player state
player = {
    x = 0,
    y = 0,
    speed = 60,
    sprite = "dave",
    direction = "down",
    moving = false,

    -- Animation state
    anim_timer = 0,
    anim_frame = 0,
    anim_speed = 0.15
}

function player_init()
    -- Start at map origin
    player.x = game.screen_width / 2 - SPRITE_SIZE / 2
    player.y = game.screen_height / 2 - SPRITE_SIZE / 2
end

function player_update(dt)
    -- Build movement vector
    local dx = 0
    local dy = 0

    if input.left then
        dx = -1
    elseif input.right then
        dx = 1
    end

    if input.up then
        dy = -1
    elseif input.down then
        dy = 1
    end

    -- Normalize diagonal movement
    if dx ~= 0 and dy ~= 0 then
        local len = math.sqrt(dx * dx + dy * dy)
        dx = dx / len
        dy = dy / len
    end

    -- Apply movement
    player.moving = (dx ~= 0 or dy ~= 0)

    if player.moving then
        player.x = player.x + dx * player.speed * dt
        player.y = player.y + dy * player.speed * dt

        -- Set facing direction (prioritize vertical for diagonal)
        if dy < 0 then
            player.direction = "up"
        elseif dy > 0 then
            player.direction = "down"
        elseif dx < 0 then
            player.direction = "left"
        elseif dx > 0 then
            player.direction = "right"
        end
    end

    -- Update animation
    player_update_animation(dt)
end

function player_update_animation(dt)
    if player.moving then
        player.anim_timer = player.anim_timer + dt
        if player.anim_timer >= player.anim_speed then
            player.anim_timer = 0
            -- Toggle between 0 and 1 for walk cycle
            player.anim_frame = 1 - player.anim_frame
        end
    else
        player.anim_timer = 0
        player.anim_frame = 0
    end
end

function player_get_sprite_frame()
    -- Get the correct frame based on direction and movement
    local frame = FRAME_IDLE
    local flip = false

    if player.direction == "down" then
        if player.moving then
            if player.anim_frame == 0 then
                frame = FRAME_DOWN_WALK
            else
                frame = FRAME_IDLE
            end
        else
            frame = FRAME_IDLE
        end
    elseif player.direction == "up" then
        if player.moving then
            if player.anim_frame == 0 then
                frame = FRAME_UP_WALK
            else
                frame = FRAME_BACK_IDLE
            end
        else
            frame = FRAME_BACK_IDLE
        end
    elseif player.direction == "left" then
        if player.moving then
            -- Alternate between left_walk and left_walk2
            if player.anim_frame == 0 then
                frame = FRAME_LEFT_WALK
            else
                frame = FRAME_LEFT_WALK2
            end
        else
            frame = FRAME_LEFT_WALK
        end
    elseif player.direction == "right" then
        -- Right is just flipped left
        flip = true
        if player.moving then
            if player.anim_frame == 0 then
                frame = FRAME_LEFT_WALK
            else
                frame = FRAME_LEFT_WALK2
            end
        else
            frame = FRAME_LEFT_WALK
        end
    end

    return frame, flip
end

function player_draw()
    local frame, flip = player_get_sprite_frame()
    sprites_draw(player.sprite, frame, player.x, player.y, flip)
end
