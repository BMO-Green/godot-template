shader_type canvas_item;
render_mode blend_mix;


uniform float strength : hint_range(-100.0, 100.0);
//uniform float heightOffset : hint_range(0.0, 1.0);


float getSway(vec2 vertex, vec2 uv, float sway_factor){
	//float sway = max(0.0, (1.0-uv.y) - heightOffset) * sway_factor;
	float sway = max(0.0, (1.0-uv.y)) * sway_factor;

	
	return sway;
}

void vertex() {
	vec4 pos = MODEL_MATRIX * vec4(0.0, 0.0, 0.0, 1.0);

    VERTEX.x += getSway(VERTEX.xy, UV, strength);
}