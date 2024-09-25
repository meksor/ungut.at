<template>
  <div>
    <fixed-background>
      <div class="light">    
        <slot />
      </div>
      <template #background>
        <shader path="assets/shaders/main.glsl"></shader>
      </template>
    </fixed-background>
  </div>
</template>

<style>
#background {
  background-color: var(--color-surface);
  mix-blend-mode: multiply;
}
</style>