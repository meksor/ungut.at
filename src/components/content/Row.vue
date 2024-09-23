<template>
  <div class="row">
    <slot></slot>
  </div>
</template>

<style lang="css">
.row {
  display: flex;
  flex-direction: row;
  flex-wrap: wrap;
  overflow: visible;
}
</style>