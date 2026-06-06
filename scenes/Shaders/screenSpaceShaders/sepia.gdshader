shader_type canvas_item;

// Godot 4 replacement
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, repeat_disable, filter_linear;

uniform vec4 base : source_color;

void fragment() {
    vec4 pixel_color = texture(SCREEN_TEXTURE, SCREEN_UV);

    COLOR = pixel_color;

    // Swap channels
    COLOR.rgb = COLOR.gbr;
}