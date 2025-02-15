<template>
  <canvas ref="shaderCanvas"></canvas>
</template>

<script setup lang="ts">
import * as twgl from 'twgl.js'

interface Texture {
  name: string
  path: string
}

interface Props {
  path: string
  textures?: Texture[]
  backBuffer?: boolean
  oneShot?: boolean
}

const props = withDefaults(defineProps<Props>(), {
  backBuffer: false,
  oneShot: false,
})

const shaderCanvas = ref()

const defaultVertexShaderSrc = `
precision highp float; 
varying vec2 vPos;
varying vec2 vFrameBufferCoord;
uniform float iRatio;
uniform vec2 iAspect;

attribute vec3 aPosition;
void main() { 
  vec2 pos =  aPosition.xy;
  vFrameBufferCoord = (pos.xy / 2.) + .5; 
  gl_Position = vec4(pos , 0.0, 1.0);
  vPos = gl_Position.xy * vec2(iAspect.x, iAspect.y) * 0.1; 
}
`
const fetchFragmentShaderSource = async () => {
  console.log(props.path)
  console.log(import.meta.url)

  const shaderUrl = new URL(props.path, new URL(import.meta.url).origin).href
  console.info(`Fetching fragment shader source from '${shaderUrl}'`)

  const res : string | Blob = await $fetch(shaderUrl)
  console.info('Fetched fragment shader source')
  if (res instanceof Blob) {
     // workaround for github pages serving .frag files as b64
     return await res.text();
  } else {
    return res;
  }
}
let vertexShader = null
let fragmentShader = null

onMounted(async () => {
  const fragmentShaderSrc = await fetchFragmentShaderSource()
  let mouse = [0.001, 0.001];
  let scrollPos = [0., 0.];

  document.onmousemove = (e) => {
    const x = (e.clientX / document.documentElement.clientWidth) -.5;
    const y = (e.clientY / document.documentElement.clientHeight) -.5;
    mouse = [x, y]
  };
  document.onscroll = (e) => {
    scrollPos = [
      window.scrollX / document.documentElement.clientWidth, 
      window.scrollY / document.documentElement.clientHeight
    ]
  };
  const gl = shaderCanvas.value.getContext('webgl')
  const programInfo = twgl.createProgramInfo(gl, [
    defaultVertexShaderSrc,
    fragmentShaderSrc,
  ])

  const arrays = {
    aPosition: [-1, -1, 0, 1, -1, 0, -1, 1, 0, -1, 1, 0, 1, -1, 0, 1, 1, 0],
  }
  
  const bufferInfo = twgl.createBufferInfoFromArrays(gl, arrays)
  const attachments = [
    { format: gl.RGBA, type: gl.UNSIGNED_BYTE, min: gl.LINEAR, wrap: gl.CLAMP_TO_EDGE },
    { format: gl.DEPTH_STENCIL, },
  ];
  let fb1 = twgl.createFramebufferInfo(gl, attachments);;
  let fb2 = twgl.createFramebufferInfo(gl, attachments);;
  let tfb = null;

  const draw = (time: number) => {
    if (twgl.resizeCanvasToDisplaySize(gl.canvas, .15)) {
      // resize the attachments
      twgl.resizeFramebufferInfo(gl, fb1);
      twgl.resizeFramebufferInfo(gl, fb2);
    } else if (props.oneShot) {
      // skip this frame if the canvas wasnt resized
      // and we are in oneshot mode
      return window.requestAnimationFrame(draw)
    }
    gl.viewport(0, 0, gl.canvas.width, gl.canvas.height)
    let minSide = Math.min(gl.canvas.width, gl.canvas.height)
    const uniforms = {
      iTime: time * 0.001,
      iResolution: [gl.canvas.width, gl.canvas.height],
      iAspect: [gl.canvas.width/minSide, gl.canvas.height/minSide],
      iRatio: gl.canvas.width / gl.canvas.height,
      tFrameBuffer: fb1.attachments[0],
      iRandom: Math.random(),
      iMouse: mouse,
      iScroll: scrollPos,
    }
    // console.debug(uniforms)
    gl.useProgram(programInfo.program)
    twgl.setBuffersAndAttributes(gl, programInfo, bufferInfo)
    twgl.setUniforms(programInfo, uniforms)

    twgl.bindFramebufferInfo(gl, null);
    twgl.drawBufferInfo(gl, bufferInfo)
    twgl.bindFramebufferInfo(gl, fb2)
    twgl.drawBufferInfo(gl, bufferInfo)

    tfb = fb1;
    fb1 = fb2;
    fb2 = tfb;

    if (shaderCanvas.value) {
      return window.requestAnimationFrame(draw)
    }
  }
  window.requestAnimationFrame(draw)

})
</script>

<style lang="scss">
canvas {
  image-rendering: optimizeSpeed;
  image-rendering: -moz-crisp-edges;
  image-rendering: -webkit-optimize-contrast;
  image-rendering: -o-crisp-edges;
  image-rendering: crisp-edges;
  image-rendering: pixelated;
  -ms-interpolation-mode: nearest-neighbor;
}
</style>
