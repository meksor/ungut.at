<template>
  <div>
    <fixed-background>
      <div class="light h-100">    
        <slot />
      </div>
      <template #background>
        <div>
          <nuxt-img fit="cover" src="/img/stars-inverted.png"></nuxt-img>
        </div>
      </template>
    </fixed-background>
  </div>
</template>

<script setup lang="ts">
</script>

<style lang="scss" scoped>
#background{
  img {
    transform: scale(1.5);
    min-height: 100%;
    image-rendering: optimizeSpeed;
    image-rendering: -moz-crisp-edges;
    image-rendering: -webkit-optimize-contrast;
    image-rendering: -o-crisp-edges;
    image-rendering: crisp-edges;
    image-rendering: pixelated;
    -ms-interpolation-mode: nearest-neighbor;

  }
}
</style>