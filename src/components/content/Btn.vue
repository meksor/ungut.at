<template>
  <nuxt-link class="button shadow hoverable fw-semi-bold fs-4 pa-2" :style="styles" :to="props.to">
    <row align-items="center" class="button__content">
      <mdi-icon  v-if="props.icon" :icon="props.icon"  class="mr-2"/>
      <span class="button__text">
        <slot>
          {{ text }}
        </slot>
      </span>
    </row>
  </nuxt-link>
</template>

<script setup lang="ts">
import type { RouterLinkProps } from 'vue-router'
import * as Icons from '@mdi/js'

type MdiIconString = keyof typeof Icons

interface Props extends RouterLinkProps {
  text?: string
  icon?: MdiIconString
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
}
.button__text { 
  overflow: visible;
  margin-bottom: -1%;
}
</style>
