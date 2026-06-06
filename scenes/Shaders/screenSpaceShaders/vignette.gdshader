shader_type canvas_item;

// Godot 4 replacement
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, repeat_disable, filter_linear_mipmap;
uniform sampler2D vignette;

void fragment() {
    vec3 vignette_color = texture(vignette, UV).rgb;

    // Screen texture stores blurred mipmaps
    COLOR.rgb = textureLod(
        SCREEN_TEXTURE,
        SCREEN_UV,
        (1.0 - vignette_color.r) * 4.0
    ).rgb;

    COLOR.rgb *= vignette_color;

    COLOR.a = 1.0;
}