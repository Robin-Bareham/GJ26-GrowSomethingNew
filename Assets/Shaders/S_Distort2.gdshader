shader_type canvas_item;

uniform vec4 line_color1: source_color = vec4(0.914, 0.310, 0.969, 1.0);
uniform vec4 line_color2: source_color = vec4(0.741, 0.149, 0.612, 1.0);
uniform float line_thickness = 2.0;

void fragment()
{
	vec4 color = texture(TEXTURE, UV);
	// If it's not highlighted
	float alpha = 0.0;
	vec2 size = TEXTURE_PIXEL_SIZE * line_thickness;

	alpha += texture(TEXTURE,UV + vec2(size.x,0.0)).a;
	alpha += texture(TEXTURE,UV + vec2(-size.x,0.0)).a;
	alpha += texture(TEXTURE,UV + vec2(0.0,size.y)).a;
	alpha += texture(TEXTURE,UV + vec2(0.0,-size.y)).a;

		//Outlines around sprite
		if(color.a == 0.0 && alpha>0.0)
		{
			if(UV.x < 0.5)
			{
				COLOR = line_color1;
			}
			else
			{
				COLOR = line_color2;
			}


		}
		else
		{
			COLOR = color;
		}
}
