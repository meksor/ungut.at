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

<style>
* {
  overflow: overlay;
  margin: 0;
  padding: 0;
}
</style>