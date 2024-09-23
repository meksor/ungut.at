<template>
  <div style="height: 100dvh; position: relative;">
    <main-menu class="mb-2"></main-menu>
  </div>
  <div style="min-height: 100vh">
    <div class="m-4 m-md-up-16">
      <imprint></imprint>
    </div>
  </div>
</template>

<script setup lang="ts">
useHead({ title: "Max Wolsch." })

definePageMeta({
  background: {
    type: "shader",
    src: "/assets/shaders/main.glsl",
    inverted: false,
  }
})
</script>


<style lang="scss">
@import '@/assets/scss/variables.scss';

.main-menu {
  position: absolute;
  bottom: 0;
  left: 0;
}
</style>
