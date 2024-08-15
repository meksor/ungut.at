<template>
  <div>
    <h1>ungut.at</h1>
    <fixed-background>
      <slot />
      <template #background>
        <shader  path="assets/shaders/torus.frag"></shader>
      </template>
    </fixed-background>
  </div>
</template>