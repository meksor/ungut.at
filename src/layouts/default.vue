<template>
  <div>
    <fixed-background>
      <div class="dark">    
        <slot />
      </div>
      <template #background>
        <shader path="assets/shaders/main.glsl"></shader>
      </template>
    </fixed-background>
  </div>
</template>

<style lang="scss" scoped>
</style>