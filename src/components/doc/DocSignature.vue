
<template>
  <p class="byline">
    <strong>Max Wolschlager</strong>
    <span v-if="props.date">, {{ displayDate }}</span>
  </p>
</template>


<script setup lang="ts">
interface Props {
  date: string;
}
const props = withDefaults(defineProps<Props>(), {
})

const displayDate = computed(() => {
  return new Date(Date.parse(props.date)).toDateString()
})
</script>

