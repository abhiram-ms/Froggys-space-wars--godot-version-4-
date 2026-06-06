shader_type canvas_item;

// Godot 4 replacement for SCREEN_TEXTURE
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, repeat_disable, filter_linear;

uniform float brightness = 0.8;
uniform float contrast = 1.5;
uniform float saturation = 1.8;

void fragment() {
    vec3 c = texture(SCREEN_TEXTURE, SCREEN_UV).rgb;

    // Brightness
    c = mix(vec3(0.0), c, brightness);

    // Contrast
    c = mix(vec3(0.5), c, contrast);

    // Saturation
    c = mix(vec3(dot(vec3(1.0 / 3.0), c)), c, saturation);

    COLOR.rgb = c;
    COLOR.a = 1.0;
}