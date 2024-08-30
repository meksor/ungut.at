<template>
  <div>
    <fixed-background>
      <div>    
        <slot />
      </div>
      <template #background>
        <shader path="assets/shaders/main.glsl"></shader>
      </template>
    </fixed-background>
  </div>
</template>

<style lang="scss">
@import '@/assets/scss/variables.scss';

* {
  overflow: overlay;
  margin: 0;
  padding: 0;
  color: map-get($shades, 'white');
}
</style>