-- graphics.lua
-- CRT post-processing shader module

local graphics = {}

-- Internal state
local canvas
local shader
local time = 0
local crt_enabled = true

-- CRT effect parameters
local params = {
    scanline_intensity = 0.15,
    curvature = 0.03,
    chromatic_aberration = 0.0013,
    vignette_intensity = 0.23,
    flicker_intensity = 0.02
}

-- GLSL shader code
local shader_code = [[
extern float time;
extern vec2 resolution;
extern float scanline_intensity;
extern float curvature;
extern float chromatic_aberration;
extern float vignette_intensity;
extern float flicker_intensity;

// Apply barrel distortion for screen curvature
vec2 curve(vec2 uv) {
    uv = uv * 2.0 - 1.0;
    vec2 offset = abs(uv.yx) / vec2(6.0, 4.0);
    uv = uv + uv * offset * offset * curvature * 10.0;
    uv = uv * 0.5 + 0.5;
    return uv;
}

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
    // Apply screen curvature
    vec2 uv = curve(texture_coords);

    // Check if we're outside the curved screen area
    if (uv.x < 0.0 || uv.x > 1.0 || uv.y < 0.0 || uv.y > 1.0) {
        return vec4(0.0, 0.0, 0.0, 1.0);
    }

    // Chromatic aberration - separate RGB channels slightly
    float r = Texel(texture, vec2(uv.x + chromatic_aberration, uv.y)).r;
    float g = Texel(texture, uv).g;
    float b = Texel(texture, vec2(uv.x - chromatic_aberration, uv.y)).b;
    vec3 col = vec3(r, g, b);

    // Scanlines
    float scanline = sin(uv.y * resolution.y * 3.14159) * 0.5 + 0.5;
    scanline = pow(scanline, 1.5);
    col *= 1.0 - scanline_intensity * (1.0 - scanline);

    // Phosphor flicker (subtle brightness variation)
    float flicker = 1.0 - flicker_intensity * sin(time * 10.0) * sin(time * 13.0);
    col *= flicker;

    // Vignette (darken edges)
    vec2 vignetteUV = uv * (1.0 - uv.xy);
    float vignette = vignetteUV.x * vignetteUV.y * 15.0;
    vignette = pow(vignette, vignette_intensity);
    col *= vignette;

    return vec4(col, 1.0) * color;
}
]]

function graphics_init()
    -- Create offscreen canvas at native resolution
    canvas = love.graphics.newCanvas(game.screen_width, game.screen_height)
    canvas:setFilter("nearest", "nearest")

    -- Compile the shader
    local success, result = pcall(love.graphics.newShader, shader_code)
    if success then
        shader = result
        -- Set initial uniforms
        shader:send("resolution", {game.screen_width, game.screen_height})
        shader:send("scanline_intensity", params.scanline_intensity)
        shader:send("curvature", params.curvature)
        shader:send("chromatic_aberration", params.chromatic_aberration)
        shader:send("vignette_intensity", params.vignette_intensity)
        shader:send("flicker_intensity", params.flicker_intensity)
        shader:send("time", 0)
    else
        print("Shader compilation failed: " .. tostring(result))
        shader = nil
    end
end

function graphics_update(dt)
    time = time + dt
    if shader and crt_enabled then
        shader:send("time", time)
    end
end

function graphics_begin()
    -- Start rendering to the offscreen canvas
    love.graphics.setCanvas(canvas)
    love.graphics.clear(0, 0, 0, 1)
end

function graphics_finish()
    -- Stop rendering to canvas
    love.graphics.setCanvas()

    -- Draw the canvas to screen with shader if enabled
    if shader and crt_enabled then
        love.graphics.setShader(shader)
    end

    -- Draw canvas scaled up
    love.graphics.draw(canvas, 0, 0, 0, game.scale, game.scale)

    -- Reset shader
    love.graphics.setShader()
end

function graphics_toggle()
    crt_enabled = not crt_enabled
    local status = crt_enabled and "ON" or "OFF"
    print("CRT filter: " .. status)
end

function graphics_is_enabled()
    return crt_enabled
end

return graphics
