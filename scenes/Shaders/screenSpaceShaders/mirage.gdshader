shader_type canvas_item;

// Godot 4 replacement
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, repeat_disable, filter_linear_mipmap;

uniform float frequency = 60.0;
uniform float depth = 0.005;

void fragment() {
    vec2 uv = SCREEN_UV;

    uv.x += sin(uv.y * frequency + TIME) * depth;
    uv.x = clamp(uv.x, 0.0, 1.0);

    vec3 c = textureLod(SCREEN_TEXTURE, uv, 0.0).rgb;

    COLOR.rgb = c;
    COLOR.a = 1.0;
}