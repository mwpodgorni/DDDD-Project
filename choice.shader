shader_type canvas_item;

uniform float white_amount;

void fragment() {
	COLOR = vec4(mix(texture(TEXTURE, UV).rgb, vec3(1,1,1), white_amount), texture(TEXTURE,UV).a);
}