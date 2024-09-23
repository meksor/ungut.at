<template>
  <NuxtLayout>
    <NuxtPage />
  </NuxtLayout>
</template>

<style>
.layout-enter-active,
.layout-leave-active {
transition: all 0.4s;
}
.layout-enter-from,
.layout-leave-to {
  filter: invert(1);
}

* {
  overflow: overlay;
  margin: 0;
  padding: 0;
}
</style>