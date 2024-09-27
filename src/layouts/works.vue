<template>
  <div>
    <fixed-background>
      <div class="light">    
        <slot />
      </div>
      <template #background>
        <shader one-shot path="assets/shaders/sticky.glsl"></shader>
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

<!--style lang="scss" scoped>
.works-layout {
  --square-color: var(--color-black);
  min-height: 100dvh;
  background-color: var(--color-surface);
  background-image: linear-gradient(90deg, var(--square-color) 2px, transparent 0),
                    linear-gradient(var(--square-color) 2px, transparent 0),
                    linear-gradient(90deg, var(--square-color) 1px, transparent 0),
                    linear-gradient(var(--square-color) 1px, transparent 0);

  background-size: 240px 240px, 240px 240px, 24px 24px, 24px 24px, 24px 24px;
  background-position: 15px 25px;
}
</style-->