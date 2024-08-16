precision lowp float;
uniform vec2 iResolution;
uniform vec2 iMouse;
uniform float iTime;
uniform float iRandom;
varying vec2 vPos;

uniform sampler2D tFrameBuffer;
varying vec2 vFrameBufferCoord;

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


vec4 findHitInScene(vec3 samplePoint) {
    vec3 col1 = vec3(.3);
    vec3 col2 = vec3(.9);
    vec3 col3 = vec3(1., 0., 0.);
    vec4 res = vec4(col1, sdTorus(samplePoint-vec3(-3.0, 0.0, 3.0),  vec2(1.2, .5)));
    res = opU(res, vec4(col3,sdSphere(samplePoint-vec3(-3.0, 0.0, 3.0), .5)));
    res = opU(res, vec4(col3,sdSphere(samplePoint-vec3(-1.0, .5, 2.0), .2)));
    return res;
}

vec4 trace(vec3 ray) {
    float near = 1.0;
    float far = 20.0;

    float distance = near;
    vec3 materialColor = vec3(.2,.4,4.);

    for (int i=0; i<128; i++) {
	    float error = 0.0004*distance;

	    vec4 hit = findHitInScene(ray * distance);
        if (hit.w<error || hit.w>far) break;
        distance += hit.w;
        materialColor = hit.rgb;
    }

    if (distance>far) {materialColor = vec3(.5);}
    return vec4(materialColor, distance);
}

vec3 calcHitNormal(vec3 samplePoint) {
    vec2 eps = vec2(1.0,-1.0)*0.5773*0.0005;
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
    float x = (iMouse.x/iResolution.x * 3.14 * 3.);
    float y = (iMouse.y/iResolution.y * 3.14 * 3.);
    return vec3(sin(x) , cos(x) , 0.);
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
            return h - .5 * align;
        };
        if (t>tmax) {
            break;
        }
    }

    return vec4(vec3(.5), 100.);
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
    if (color.r < .95) {
        return (color * shd.rgb - .2*align) - .1*occ;

    } else {
        return (color *.6 - .2*align) - .2*occ;
    }
}
vec3 render(vec3 ray) {
    vec4 traceResult = trace(ray);
    return vec3(clamp(applyLightModifiers(traceResult, ray), 0.0, 1.0));
}
float rand (vec2 st) {
    return fract(sin(dot(st.xy,  vec2(12.9898,78.233))) * 43758.5453123);
}

void mainImage (vec2 fragCoord) {
    // Coordinates with the origin in the center of the picture
    vec2 coordinates = fragCoord.xy;
    // vec2 coordinates = (fragCoord.xy);
    vec3 orientation = vec3(-1. , 0., 1.);
    mat3 camOrientationMatrix = camera(orientation, 0.0);

    float focalLength = 1.5;
    vec3 rayDirection = camOrientationMatrix * normalize(vec3(coordinates.xy, focalLength));

    vec3 color = render(rayDirection);

    // Gamma
    color =  pow( color, vec3(0.4545) );
    // gl_FragColor = vec4( coordinates.xyy, 1.);
    float ra = rand(vec2(gl_FragCoord[1], gl_FragCoord[0]) * iRandom);
    if (ra > .9) {
        gl_FragColor =  vec4( color, 1.);
    } else {
        vec4 last = texture2D(tFrameBuffer, vFrameBufferCoord);
        gl_FragColor = last * .99;
        // gl_FragColor = vec4( vPos / iResolution, 1, 1);
    }

}

void main() {
    mainImage(vPos);
}


