<template>
  <div>
    <fixed-background>
      <div>    
        <h1>ungut.at</h1>
        <slot />
      </div>
      <template #background>
        <shader  path="assets/shaders/torus.frag"></shader>
      </template>
    </fixed-background>
  </div>
</template>