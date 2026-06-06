shader_type canvas_item;
uniform vec2 scale_uniform;
uniform sampler2D make_texture;

void fragment(){
	vec2 uv = vec2(UV.x -TIME*3.0,UV.y);
	vec4 text = texture(TEXTURE,uv);
	COLOR = text;
}
