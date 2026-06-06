shader_type canvas_item;

// Godot 4 replacement
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, repeat_disable, filter_linear_mipmap;

void fragment() {
    vec3 c = textureLod(SCREEN_TEXTURE, SCREEN_UV, 0.0).rgb;

    c = vec3(1.0) - c;

    COLOR.rgb = c;
    COLOR.a = 1.0;
}