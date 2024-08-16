<template>
  <div>
    <fixed-background>
      <div>    
        <slot />
      </div>
      <template #background>
        <shader path="assets/shaders/main.txt"></shader>
      </template>
    </fixed-background>
  </div>
</template>