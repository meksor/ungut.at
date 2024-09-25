<template>
  <nuxt-img class="shadow hoverable" v-bind="props"> </nuxt-img>
</template>


<script setup lang="ts">
interface Props {
  src?: string
  alt?: string
  width?: string | number
  height?: string | number
}

const props = withDefaults(defineProps<Props>(), {})

</script>