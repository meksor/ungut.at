precision highp float;
uniform vec2 iMouse;
uniform vec2 iScroll;
uniform float iTime;
uniform float iRandom;
varying vec2 vPos;

uniform sampler2D tFrameBuffer;
varying vec2 vFrameBufferCoord;
float blendScreen(float base, float blend) {
	return 1.0-((1.0-base)*(1.0-blend));
}

vec3 blendScreen(vec3 base, vec3 blend) {
	return vec3(blendScreen(base.r,blend.r),blendScreen(base.g,blend.g),blendScreen(base.b,blend.b));
}

vec3 blendScreen(vec3 base, vec3 blend, float opacity) {
	return (blendScreen(base, blend) * opacity + base * (1.0 - opacity));
}
float rand (vec2 st) {
   return fract(sin(dot(st.xy,  vec2(12.9898,78.233))) * 43758.5453123);
   //return tan(dot(st.xy,  vec2(1.)));
}

mat3 camera(vec3 orientation, float roll) {
    orientation = normalize(orientation);
	vec3 cp = vec3(sin(roll), cos(roll), 0.0);
	vec3 cu = normalize( cross(orientation, cp) );
	vec3 cv = normalize( cross(cu, orientation) );
    return mat3( cu, cv, orientation );
}

float sdSphere( vec3 p, float s )
{
    return length(p)-s;
}

float sdCutHollowSphere( vec3 p, float r, float h, float t )
{
  // sampling independent computations (only depend on shape)
  float w = sqrt(r*r-h*h);
  
  // sampling dependant computations
  vec2 q = vec2( length(p.xz), p.y );
  return ((h*q.x<w*q.y) ? length(q-vec2(w,h)) : 
                          abs(length(q)-r) ) - t;
}

vec4 opU( vec4 d1, vec4 d2 )
{
	return (d1.w<d2.w) ? d1 : d2;
}

vec4 opSmoothUnion( vec4 d1, vec4 d2, float k )
{
    float h = clamp( 0.5 + 0.5*(d1.w-d2.w)/k, 0.0, 1.0 );
    float d = mix( d1.w, d2.w, h ) - k*h*(1.0-h);
    return vec4(mix( d1.rgb, d2.rgb, h ), d);
}
vec4 opSmoothSubtraction( vec4 d1, vec4 d2, float k )
{
    float h = clamp( 0.5 - 0.5*(d2.w+d1.w)/k, 0.0, 1.0 );
    float d = mix( d1.w, d2.w, h ) - k*h*(1.0-h);
    return vec4(mix( d1.rgb, d2.rgb, h ), d);
}

float opDisplace( float d1, in vec3 p )
{
    float d2 = sin(20.*p.x)*sin(20.*p.y)*sin(20.*p.z);
    return d1+d2;
}
vec3 opTwist( in vec3 p )
{
    float k = 50. + 100. * sin(iTime); // or some other amount
    float c = cos(k*p.y);
    float s = sin(k*p.y);
    mat2  m = mat2(c,-s,s,c);
    vec3  q = vec3(m*p.xz,p.y);
    return q;
}
float sinc( float x, float k )
{
    float a = 3.14159*(k*x-1.0);
    return sin(a)/a;
}

vec4 findHitInScene(vec3 samplePoint) {
    vec3 col1 = vec3(.7, .7, .9);
    vec3 col2 = vec3(.4);
    vec3 col3 = vec3(.6);
    vec4 s1 = vec4(col1, sdSphere(samplePoint-vec3(-2.5, .5*sin(iTime*3.2), .74*cos(iTime*3.2)), .1));
    vec4 s3 = vec4(col1, sdSphere(samplePoint-vec3(-2.5, -.25*sin(iTime*3.2), -0.25*cos(iTime*3.2)), .1));

    vec4 s2 = vec4(col2, sdCutHollowSphere(opTwist(samplePoint-vec3(-2.5, 0., 0.0)), .5, .15, .15));
    vec4 res = s2;
    res = opSmoothUnion(res, s1, .9);
    res = opSmoothUnion(res, s3, .5);
	res.w = opDisplace(res.w, samplePoint);
    return res;
}

vec4 trace(vec3 ray) {
    float near = 1.0;
    float far = 20.0;

    float distance = near;
    vec3 materialColor = vec3(1.);

    for (int i=0; i<64; i++) {
	    float error = 0.0004*distance;

	    vec4 hit = findHitInScene(ray * distance);
        if (hit.w<error || hit.w>far) break;
        distance += hit.w;
        materialColor = hit.rgb;
    }
    if (distance>far) {materialColor = vec3(1.);}

    return vec4(materialColor, distance);
}

vec3 calcHitNormal(vec3 samplePoint) {
    vec2 eps = vec2(1.0,-1.0)*0.2123;
    return normalize( eps.xyy*findHitInScene( samplePoint + eps.xyy ).w +
					  eps.yyx*findHitInScene( samplePoint + eps.yyx ).w +
					  eps.yxy*findHitInScene( samplePoint + eps.yxy ).w +
					  eps.xxx*findHitInScene( samplePoint + eps.xxx ).w );
}

vec3 getLightDir() {
        
    float x = tan(-iMouse.y * 3.14);
    float y = sin(-iMouse.x * 3.14);
    return normalize(vec3(-1., x, y));
}


float fresnel_schlick_ratio(float cos_theta_incident, float power) {
	float p = 1. - cos_theta_incident;
	return pow(p, power);
}

vec3 applyLightModifiers(vec4 traceResult, vec3 ray) {
    vec3 color = traceResult.rgb;
    float dist = traceResult.a;
    if (dist > 15.) {
        return color;
    }
    vec3 pos = ray * dist;
    vec3 normal = calcHitNormal(pos);
    vec3 lightDir = getLightDir();

    vec3 ref = reflect(ray, normal);
    float align = dot(lightDir, ref);
    return (color + .5*abs(align));
}
vec3 render(vec3 ray) {
    vec4 traceResult = trace(ray);
    return vec3(clamp(applyLightModifiers(traceResult, ray), 0.0, 1.0));
}

void mainImage (vec2 fragCoord) {
    vec2 coordinates = fragCoord.xy;
    
    float y = iMouse.y * .01;
    float z = iMouse.x * .01;
    vec3 orientation = normalize(vec3(-1., y, z));
    mat3 camOrientationMatrix = camera(orientation, 0.0);

    float focalLength = 1.5;
    vec3 rayDirection = camOrientationMatrix * normalize(vec3(coordinates.xy, focalLength));

    vec3 color = render(rayDirection);

    color =  pow( color, vec3(0.4545) );
	gl_FragColor =  vec4( color, 1.);
}

void main() {
    mainImage(vPos);
}
