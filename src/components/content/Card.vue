<template>
  <div class="card shadow" :style="styles">
    <slot></slot>
    <div class="card__background" :style="bgStyles">
      <slot name="background"></slot>
    </div>
  </div>
</template>

<script setup lang="ts">
interface Props {
  color?: string
  borderColor?: string
  aspectRatio?: string
}

const props = withDefaults(defineProps<Props>(), {
  color: 'surface',
  borderColor: 'black',
  aspectRatio: 'unset',
})

const styles = computed(() =>
{
  return {
    borderColor: `var(--color-${props.borderColor})`,
    aspectRatio: props.aspectRatio
  }
})
const bgStyles = computed(() =>
{
  return {
    backgroundColor: `var(--color-${props.color})`,
  }
})

</script>


<style lang="scss">
.card {
  border-width: 1px;
  border-style: solid;
  position: relative;
  display: block;
  z-index: 0;
}
.card__background {
  position: absolute;
  overflow: hidden;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  z-index: -1;
}
</style>
