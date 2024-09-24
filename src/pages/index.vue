<template>
  <div style="height: 100dvh; position: relative;">
    <main-menu class="mb-2 font-tiny5"></main-menu>
  </div>
  <div style="min-height: 100vh">
    <div class="m-4 m-md-up-16 font-tiny5">
      <imprint></imprint>
    </div>
  </div>
</template>


<script setup lang="ts">

definePageMeta({ 
  documentDriven: { page: false, surround: false }
}) 

</script>

<style lang="scss">
@import '@/assets/scss/variables.scss';

.main-menu {
  position: absolute;
  bottom: 0;
  left: 0;
}
</style>
