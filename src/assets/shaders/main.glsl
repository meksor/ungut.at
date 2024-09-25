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


float sinc( float x, float k )
{
    float a = 3.14159*(k*x-1.0);
    return sin(a)/a;
}

vec4 findHitInScene(vec3 samplePoint) {
    samplePoint = vec3(samplePoint.x, samplePoint.y - iScroll.y, samplePoint.z);
    vec3 col3 = vec3(.5, .7, .9);
    float freq = sin(iTime);
    float freq2 = sin(iTime/2.);
    float freq3 = sin(iTime/3.);
    float freq5 = sin(iTime/5.);
    vec4 s1 = vec4(col3 , sdSphere(samplePoint-vec3(cos(iTime)-10.0, cos(iTime) + freq3, freq * freq5 + freq2), .1));
    vec4 s3 = vec4(col3, sdSphere(samplePoint-vec3(sin(iTime)-10.5, freq + freq5, freq * freq3 + freq2), .1));

    float s2size = .3 + sinc(freq5, freq2) * .3;
    // float s2col = step(.9, sin(290. * dot(normalize(samplePoint), normalize(vec3(sin(iTime/20.), cos(iTime/20.), 3.))))) * .5;
    // vec4 s2 = vec4(vec3(s2col, s2col,max(s2col, .12)), sdSphere(samplePoint-vec3(-10.5, 0., 0.0), .1 + .3 * s2size));
    vec4 s2 = vec4(vec3(.75), sdSphere(samplePoint-vec3(-10.5, 0., 0.0), .1 + .3 * s2size));
    vec4 res = s2;
    res = opSmoothUnion(res, s1, .9);
    res = opSmoothUnion(res, s3, .5);
    return res;
}

vec4 trace(vec3 ray) {
    float near = 1.0;
    float far = 20.0;

    float distance = near;
    vec3 materialColor = vec3(1.);

    for (int i=0; i<64; i++) {
	    float error = 0.0006*distance;

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

vec4 calcRef( in vec3 ro, in vec3 rd, in float mint, in float tmax )
{
    // bounding volume
    float tp = (0.8-ro.y)/rd.y; if( tp>0.0 ) tmax = min( tmax, tp );

    float res = 1.0;
    float t = mint;
    for( int i=0; i<32; i++ )
    {
		vec4 h = findHitInScene( ro + rd*t);
        float s = clamp(8.0*h.w/t,0.0,1.0);
        res = min( res, s );
        t += clamp( h.w, 0.01, 0.2 );
        if( res<0.004) {
            vec3 pos = rd * h.w;
            vec3 normal = calcHitNormal(pos);
            vec3 lightDir = getLightDir();

            vec3 ref = reflect(rd, normal);
            float align = dot(lightDir, ref);
            return h + .2 * align;
        };
        if (t>tmax) {
            break;
        }
    }

    return vec4(vec3(1.), 100.);
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
    vec4 shd = calcRef(pos, ref, 0.02, 10.);
    color = color * shd.rgb + shd.rgb *.05;
    return (color + .5*align) - .2;
}
vec3 render(vec3 ray) {
    vec4 traceResult = trace(ray);
    return vec3(clamp(applyLightModifiers(traceResult, ray), 0.0, 1.0));
}

void mainImage (vec2 fragCoord) {
    // Coordinates with the origin in the center of the picture
    vec2 coordinates = fragCoord.xy;
    // vec2 coordinates = (fragCoord.xy);
    
    float y = iMouse.y * .01;
    float z = iMouse.x * .01;
    vec3 orientation = normalize(vec3(-1., y, z));
    mat3 camOrientationMatrix = camera(orientation, 0.0);

    float focalLength = 1.5;
    vec3 rayDirection = camOrientationMatrix * normalize(vec3(coordinates.xy, focalLength));

    vec3 color = render(rayDirection);

    // Gamma
    color =  pow( color, vec3(0.4545) );
    // gl_FragColor = vec4( coordinates.xyy, 1.);
    float ra = rand(vec2(gl_FragCoord[1], gl_FragCoord[0]) * iRandom);
    vec4 last = texture2D(tFrameBuffer, vFrameBufferCoord);
    if (ra > .8) {
        gl_FragColor =  vec4( color, 1.);
    } else {
        gl_FragColor = vec4( last.rgb, 1.);
    }
}

void main() {
    mainImage(vPos);
}
