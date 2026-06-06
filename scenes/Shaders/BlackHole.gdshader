shader_type canvas_item;

uniform float strength = 0.01;
uniform float black_radius = 0.65;
uniform sampler2D ex_texture;

// Godot 4 replacement for SCREEN_TEXTURE
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, repeat_disable, filter_linear;

void fragment() {
    // Get direction and distance to the black hole center
    vec2 diff = vec2(0.5, 0.5) - vec2(UV.x, 1.0 - UV.y);
    float d = length(diff) * 2.0;
    vec2 dir = normalize(diff);
    float f = clamp(1.0 - d, 0.0, 1.0);

    // Smooth transition near edges
    float shelf = smoothstep(0.0, 2.0, f);

    // Calculate displacement amount
    float displacement = strength / (d * d + 0.01);

    // Distorted screen UV
    vec2 uv = SCREEN_UV + dir * (displacement * shelf);

    // Sample screen texture
    vec3 col = texture(SCREEN_TEXTURE, uv).rgb;

    // Final color
    COLOR.rgb = mix(
        col,
        vec3(0.0, 0.0, 0.0),
        smoothstep(black_radius - 0.01, black_radius + 0.1, f)
    );

    COLOR.a = 1.0;
}