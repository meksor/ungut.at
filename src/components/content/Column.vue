<template>
  <div class="col" :style="styles">
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
.col {
  display: flex;
  flex-direction: column;
  flex-wrap: wrap;
  overflow: visible;
}
</style>

