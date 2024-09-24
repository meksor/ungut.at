<template>
  <div class="imprint body-bold mb-4">
    <ContentDoc path="/imprint" />
  </div>
  <div class="imprint body-bold">
    <ContentDoc path="/legal" />
  </div>
</template>


<style lang="scss">
@import '@/assets/scss/variables.scss';

.imprint {
    color: map-get($shades, 'white') !important;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    max-width: 700px;
}
</style>