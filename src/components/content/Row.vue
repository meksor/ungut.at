<template>
  <div class="row" :style="styles">
    <slot></slot>
  </div>
</template>

<script setup lang="ts">
type AlignItemsProperty = "center" | "start" | "end" | string & {}
type JustifyContentProperty = "center" | "space-between" | "space-around" | string & {}

interface Props {
  justifyContent?: JustifyContentProperty;
  alignItems?: AlignItemsProperty;
}

const props = withDefaults(defineProps<Props>(), {
})
const styles = computed(() =>
{
  return {
    justifyContent: props.justifyContent,
    alignItems: props.alignItems
  }
})

</script>
  
<style lang="css">
.row {
  display: flex;
  flex-direction: row;
  flex-wrap: wrap;
  overflow: visible;
}
</style>
