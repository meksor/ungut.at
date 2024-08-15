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
  backBuffer?: bool
}

const props = withDefaults(defineProps<Props>(), {
  backBuffer: false,
})

const shaderCanvas = ref()

const defaultVertexShaderSrc = `
precision highp float; 
varying vec2 vPos;
attribute vec2 iResolution;

attribute vec3 aPosition;
void main() { 
    vPos = (gl_Position = vec4(aPosition,1.0)).xy; 
}
`
const fetchFragmentShaderSource = async () => {
  const shaderUrl = new URL(`/${props.path}`, import.meta.url).href
  console.info(`Fetching fragment shader source from '${shaderUrl}'`)

  const { data: shaderSrc } = await useFetch(shaderUrl)
  console.info('Fetched fragment shader source')
  return shaderSrc.value
}
let vertexShader = null
let fragmentShader = null

onMounted(async () => {
  const fragmentShaderSrc = await fetchFragmentShaderSource()

  const gl = shaderCanvas.value.getContext('webgl')
  const programInfo = twgl.createProgramInfo(gl, [
    defaultVertexShaderSrc,
    fragmentShaderSrc,
  ])

  const arrays = {
    aPosition: [-1, -1, 0, 1, -1, 0, -1, 1, 0, -1, 1, 0, 1, -1, 0, 1, 1, 0],
  }
  const bufferInfo = twgl.createBufferInfoFromArrays(gl, arrays)

  // const fbi = twgl.createFramebufferInfo(gl);
  const draw = (time) => {
    if (twgl.resizeCanvasToDisplaySize(gl.canvas, 0.1)) {
      // resize the attachments
      // twgl.resizeFramebufferInfo(gl, fbi);
    }    
    // gl.bindFramebuffer(gl.FRAMEBUFFER, fbi.framebuffer);
    gl.viewport(0, 0, gl.canvas.width, gl.canvas.height)

    const uniforms = {
      iTime: time * 0.001,
      iResolution: [gl.canvas.width, gl.canvas.height],
    }
    gl.useProgram(programInfo.program)

    twgl.setBuffersAndAttributes(gl, programInfo, bufferInfo)
    twgl.setUniforms(programInfo, uniforms)
    twgl.drawBufferInfo(gl, bufferInfo)
    window.requestAnimationFrame(draw)
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
