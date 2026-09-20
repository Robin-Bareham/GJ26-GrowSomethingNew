shader_type canvas_item;

uniform vec4 line_color: source_color = vec4(0.6,0.6,0.6,1.0);
uniform vec4 fill_color: source_color = vec4(0.0,0.0,0.0,1.0);
uniform float fill_intensity: hint_range(0.0,1.0) = 0.9;
uniform float selected_intensity: hint_range(0.0,1.0) = 0.5;
uniform float line_thickness = 2.0;
uniform bool highlighted = false;

void fragment()
{
	vec4 color = texture(TEXTURE, UV);
	// If it's not highlighted


	if(!highlighted)
	{
		if(color.a < 0.01)
		{
			discard;
		}
		else
		{
			vec4 new_color = mix(color,fill_color,fill_intensity);
			new_color.a = color.a;
			COLOR = new_color;
		}
	}
	else
	{
		float alpha = 0.0;
		vec2 size = TEXTURE_PIXEL_SIZE * line_thickness;

		alpha += texture(TEXTURE,UV + vec2(size.x,0.0)).a;
		alpha += texture(TEXTURE,UV + vec2(-size.x,0.0)).a;
		alpha += texture(TEXTURE,UV + vec2(0.0,size.y)).a;
		alpha += texture(TEXTURE,UV + vec2(0.0,-size.y)).a;

		//Outlines around sprite
		if(color.a == 0.0 && alpha>0.0)
		{
			COLOR = line_color;
		}
		else
		{
			vec4 new_color = mix(color,fill_color,selected_intensity);
			new_color.a = color.a;
			COLOR = new_color;
		}

	}
}
