shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, filter_linear_mipmap;
instance uniform float blur_amount: hint_range(0.0,5.0) = 1.5; //Instance allows it to be changed

void fragment()
{
	
	vec3 result = textureLod(SCREEN_TEXTURE,SCREEN_UV,blur_amount).rgb;
	COLOR = vec4(result,1.0);
	
	
}

//Code: https://youtu.be/Z2o6IfmK61A?si=Vt6685znvTWIaMv9

