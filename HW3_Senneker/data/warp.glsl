#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;
uniform vec2 texOffset;//UV width/height of a pixel

varying vec4 vertColor;
varying vec4 vertTexCoord;//UV Coordinate

uniform float scale;
uniform vec2 center;
uniform float radius;

void main(){

	vec2 pos = vertTexCoord.xy;
	vec4 color = texture2D(texture,vertTexCoord.xy);
	
	float dx;
	float dy;

	dx = center.x  - vertTexCoord.x;
	dy = center.y - vertTexCoord.y;

	dx *= texOffset.y/texOffset.x;

	if (dx*dx + dy*dy < radius * radius && dx*dx + dy*dy > (radius*.75) * (radius*.75)){

	float lerpAmount = (dx*dx+dy*dy)/(radius*radius);
	if(lerpAmount >1) lerpAmount = 1;

	lerpAmount = sin(lerpAmount * 3.14159/2);
	scale = mix(scale,1,lerpAmount);

	//vec2 center = vec2(.5,.5);
	//STEP 1: GET VECTOR FROM CENTER
	float x;
	float y;

	x = pos.x - center.x;
	y = pos.y - center.y;

	//STEP 2: SCALE VECTOR;
	x *= scale;
	y *= scale;

	//STEP 3: REPOSITION VECTOR TO CENTER
	x += center.x;
	y += center.y;

	//STEP 4: SAMPLE TEXTURE
	//color = texture2D(texture, vec2(x,y));
	color = texture2D(texture, vec2(x,y));
}


	
	//color = vec4(0,0,1,1);

	gl_FragColor = color;
}