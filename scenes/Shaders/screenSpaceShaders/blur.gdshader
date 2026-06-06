shader_type canvas_item;

// Godot 4 screen texture replacement
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, repeat_disable, filter_linear_mipmap;

uniform float amount : hint_range(0.0, 5.0);

void fragment() {
    COLOR.rgb = textureLod(SCREEN_TEXTURE, SCREEN_UV, amount).rgb;
    COLOR.a = 1.0;
}