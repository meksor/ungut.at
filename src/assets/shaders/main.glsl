precision highp float;
uniform vec2 iMouse;
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

float sdPlane( vec3 p, vec3 n, float h )
{
  // n must be normalized
  return dot(p,n) + h;
}

float sdSphere( vec3 p, float s )
{
    return length(p)-s;
}


float sdTorus( vec3 p, vec2 t )
{
    mat3 mat = camera(vec3(sin(iTime/2.) * 3., cos(iTime/6.) * 3., 1.), 0.0);
    p = p*mat;
    return length( vec2(length(p.xy)-t.x,p.z) )-t.y;
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
    vec3 col1 = vec3(.2);
    vec3 col2 = vec3(.8, .8, .9);
    vec3 col3 = vec3(1., 0., 0.);
    // vec4 torus = vec4(col1, sdTorus(samplePoint-vec3(-15.0, 0.0, 0.0),  vec2(1.2, .5)));
    vec4 s1 = vec4(col3 , sdSphere(samplePoint-vec3(cos(iTime)-10.0, cos(iTime) + sin(iTime/3.), sin(iTime) * sin(iTime/5.) + sin(iTime/2.)), .1));
    vec4 s3 = vec4(col3, sdSphere(samplePoint-vec3(sin(iTime)-10.5, sin(iTime) + sin(iTime/5.), sin(iTime) * sin(iTime/3.) + sin(iTime/2.)), .1));

    float s2size = .3 + sinc(sin(iTime/5.), sin(iTime/2.)) * .3;
    float s2col = step(.9, sin(290. * dot(normalize(samplePoint), normalize(vec3(sin(iTime/20.), cos(iTime/20.), 3.))))) * .5;
    vec4 s2 = vec4(vec3(s2col), sdSphere(samplePoint-vec3(-10.5, 0., 0.0), .1 + .3 * s2size));
    vec4 res = s1;
    res = opSmoothUnion(res, s2, .9);
    res = opSmoothUnion(res, s3, .5);
    res = opSmoothUnion(res, s2, .5);
    return res;
}

vec3 background(vec3 ray) {
    mat3 rot = camera(vec3(1., 1., 1.), sin(iTime/314000.));
    float pos = dot(rot * ray, vec3(1.2, 0., 0.35));
    float r = step(.999, sin(10000. * pos - cos(15000. *pos)));
    return vec3(.05, .05, 0.05) * r;
}

vec4 trace(vec3 ray) {
    float near = 1.0;
    float far = 20.0;

    float distance = near;
    vec3 materialColor = vec3(.2,.2,.2);

    for (int i=0; i<128; i++) {
	    float error = 0.0004*distance;

	    vec4 hit = findHitInScene(ray * distance);
        if (hit.w<error || hit.w>far) break;
        distance += hit.w;
        materialColor = hit.rgb;
    }

    if (distance>far) {materialColor = background(ray);}
    return vec4(materialColor, distance);
}

vec3 calcHitNormal(vec3 samplePoint) {
    vec2 eps = vec2(1.0,-1.0)*0.1;
    return normalize( eps.xyy*findHitInScene( samplePoint + eps.xyy ).w +
					  eps.yyx*findHitInScene( samplePoint + eps.yyx ).w +
					  eps.yxy*findHitInScene( samplePoint + eps.yxy ).w +
					  eps.xxx*findHitInScene( samplePoint + eps.xxx ).w );
}

float calcAO( in vec3 pos, in vec3 nor )
{
	float occ = 0.0;
    float sca = 1.0;
    for( int i=0; i<5; i++ )
    {
        float h = 0.01 + 0.12*float(i)/4.0;
        float d = findHitInScene( pos + h*nor ).w;
        occ += (h-d)*sca;
        sca *= 0.95;
        if( occ>0.35 ) break;
    }
    return clamp( 1.0 - 3.0*occ, 0.0, 1.0 ) * (0.5+0.5*nor.y);
}

vec3 getLightDir() {
    return vec3(.1, 0.2, 0.);
    float x = (iTime* 3.14 / 2.);
    float y = (iTime* 3.14 / 2.);
    return vec3(0., sin(x), cos(y));
}

vec4 calcRef( in vec3 ro, in vec3 rd, in float mint, in float tmax )
{
    // bounding volume
    float tp = (0.8-ro.y)/rd.y; if( tp>0.0 ) tmax = min( tmax, tp );

    float res = 1.0;
    float t = mint;
    for( int i=0; i<24; i++ )
    {
		vec4 h = findHitInScene( ro + rd*t );
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
    float occ = calcAO( pos, normal );
    vec4 shd = calcRef( pos, ref, 0.002, 10. );
    color = color * shd.rgb + shd.rgb *.05;
    return (color + .2*align) - .1*occ;
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
        // gl_FragColor = vec4( vPos / iResolution, 1, 1);
    }

}

void main() {
    mainImage(vPos);
}


