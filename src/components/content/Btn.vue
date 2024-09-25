<template>
  <nuxt-link class="button shadow hoverable fw-semi-bold fs-2 pa-2" :style="styles" :to="props.to">
    <row align-items="center">
      <slot>
        {{ text }}
      </slot>
    </row>
  </nuxt-link>
</template>

<script setup lang="ts">
import type { RouterLinkProps } from 'vue-router'

interface Props extends RouterLinkProps {
  text?: string
  color?: string
  borderColor?: string
  aspectRatio?: string
}

const props = withDefaults(defineProps<Props>(), {
  color: 'surface',
  borderColor: 'black',
})

const styles = computed(() =>
{
  return {
    borderColor: `var(--color-${props.borderColor})`,
    backgroundColor: `var(--color-${props.color})`,
  }
})
</script>


<style lang="scss">
.button {
  border-width: 1px;
  border-style: solid;
  position: relative;
  display: inline-block;
  z-index: 0;
  text-transform: uppercase;
  text-decoration: none;
  cursor: pointer;
  color: inherit;
  line-height: 100% !important;
}
</style>
