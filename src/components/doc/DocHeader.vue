<template>
  <div class="of-visible el-1">
    <row justify-content="space-between">
      <div class="mb-2">
        <h1 class="mb-1">{{ doc.title }}</h1>
        <div>{{ doc.subtitle }}</div>
      </div>
      <div class="mb-2">
        <strong>{{ displayDate }}</strong>
      </div>
    </row>
    <divider class="mb-2"/>
    <row justify-content="start">
      <btn v-for="link in doc.links" :to="link.url" target="_blank" class="mr-2 my-2">
        <mdi-icon v-if="link.icon" :icon="link.icon" class="mr-2"/>
        {{ link.title }}
      </btn>
    </row>
  </div>  
</template>
  
  
<script setup lang="ts">
import type { ParsedContent } from '@nuxt/content'
interface Props {
  doc: ParsedContent
}

const props = withDefaults(defineProps<Props>(), {
})

const displayDate = computed(() => {
  return new Date(Date.parse(props.doc.date)).toDateString()
})

</script>

<style lang="scss">

</style>