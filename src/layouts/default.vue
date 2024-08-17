<template>
  <div>
    <fixed-background>
      <div>    
        <slot />
      </div>
      <template #background>
        <shader path="assets/shaders/main.frag"></shader>
      </template>
    </fixed-background>
  </div>
</template>