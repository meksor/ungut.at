<template>
    <div class="divider" :class="{'h-100': props.vertical, 'w-100': props.horizontal && !props.vertical}"></div>
</template>

<script setup lang="ts">
interface Props {
    vertical?: boolean;
    horizontal?: boolean;
}

const props = withDefaults(defineProps<Props>(), {
    horizontal: true
})

</script>
  
<style lang="scss">
.divider.w-100 {
    border-bottom: 1px solid black;
}
.divider.h-100 {
    border-left: 1px solid black;
}
</style>
