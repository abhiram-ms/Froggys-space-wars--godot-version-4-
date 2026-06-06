shader_type canvas_item;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, repeat_disable, filter_linear;

void fragment() {
    vec4 bg = texture(SCREEN_TEXTURE, SCREEN_UV);
    float gray = dot(bg.rgb, vec3(0.299, 0.587, 0.114));
    COLOR = vec4(vec3(gray), 1.0);
}